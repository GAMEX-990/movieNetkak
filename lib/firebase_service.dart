import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ฟังก์ชันล็อกอินพร้อมบันทึกข้อมูลใน Firestore
  static Future<String> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return 'กรุณากรอกอีเมลและรหัสผ่าน';
      }

      // ทำการล็อกอิน
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // ดึงข้อมูลผู้ใช้จาก Firestore
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userData.exists) {
        // ถ้ายังไม่มีข้อมูลในคอลเลกชัน users ให้สร้างใหม่
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'เวลาเข้าสู่ระบบล่าสุด': FieldValue.serverTimestamp(),
          'วันที่สร้างบัญชี': FieldValue.serverTimestamp(),
        });
      } else {
        // อัพเดทเวลาเข้าสู่ระบบล่าสุด
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({
          'เวลาเข้าสู่ระบบล่าสุด': FieldValue.serverTimestamp(),
        });
      }

      return "Login successful";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'ไม่พบบัญชีผู้ใช้นี้';
      } else if (e.code == 'wrong-password') {
        return 'รหัสผ่านไม่ถูกต้อง';
      } else if (e.code == 'invalid-email') {
        return 'อีเมลไม่ถูกต้อง';
      } else if (e.code == 'user-disabled') {
        return 'บัญชีผู้ใช้นี้ถูกระงับการใช้งาน';
      }
      return 'เข้าสู่ระบบล้มเหลว: ${e.message}';
    } catch (e) {
      return 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ';
    }
  }

  // ฟังก์ชันสมัครสมาชิกพร้อมบันทึกข้อมูลใน Firestore
  static Future<String> signup(
      String email, String password, String displayName) async {
    try {
      // สร้างบัญชีผู้ใช้ใหม่
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // สร้างเอกสารข้อมูลผู้ใช้ใน Firestore
      // ตัวอย่างการแก้ไขในส่วนของการบันทึกข้อมูล
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });

      return "สมัครสมาชิกสำเร็จ";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'รหัสผ่านไม่ปลอดภัยเพียงพอ';
      } else if (e.code == 'email-already-in-use') {
        return 'มีบัญชีผู้ใช้นี้อยู่แล้ว';
      }
      return "สมัครสมาชิกไม่สำเร็จ: ${e.message}";
    } catch (e) {
      return "สมัครสมาชิกไม่สำเร็จ: $e";
    }
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จาก Firestore
  static Future<Map<String, dynamic>?> getUserData() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

static Future<void> addToFavorites(String movieTitle) async {
  User? currentUser = _auth.currentUser;
  if (currentUser != null) {
    try {
      await _firestore.collection('users').doc(currentUser.uid).set({
        'favorites': FieldValue.arrayUnion([movieTitle])
      }, SetOptions(merge: true));  // ใช้ merge: true เพื่อไม่ให้เขียนทับข้อมูลเดิมทั้งหมด
    } catch (e) {
      print('Error adding to favorites: $e');
      rethrow;  // ส่งต่อ error ไปให้ UI จัดการ
    }
  }
}

static Future<void> removeFromFavorites(String movieTitle) async {
  User? currentUser = _auth.currentUser;
  if (currentUser != null) {
    try {
      await _firestore.collection('users').doc(currentUser.uid).update({
        'favorites': FieldValue.arrayRemove([movieTitle])
      });
    } catch (e) {
      print('Error removing from favorites: $e');
      rethrow;
    }
  }
}

  // ดึงรายการหนังโปรดทั้งหมด
  static Future<List<String>> getFavorites() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();
      
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('favorites')) {
          return List<String>.from(data['favorites']);
        }
      }
    }
    return [];
  }
}

