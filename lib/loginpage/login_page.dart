import 'package:flutter/material.dart';
import 'package:fluttermovie/dashboard_page/dashboard_page.dart';
import 'package:fluttermovie/firebase_service.dart';
import 'package:fluttermovie/signup_page/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color _backgroundColor = Color.fromARGB(255, 1, 7, 21);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

//อันนี้ AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "welcome To Login",
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      backgroundColor: _backgroundColor,
      bottom: _buildAppBarDivider(),
      // เส้นแบ่งใต้ AppBar
    );
  }

  PreferredSizeWidget _buildAppBarDivider() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(6.0),
      child: Divider(
        height: 1.0,
        color: Colors.white,
      ),
    );
  }

//เอาไว้ใส่เนื้อหา Widget ฮ๊าฟฟุ้ววว
  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: _backgroundColor,
      child: Column(children: [
        _TextHomeLogin(),
        _buildInputFields(),
        _buildLoginBotton(context),
        _Signupage(context)
      ]),
    );
  }

  Widget _buildInputFields() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your password',
            icon: Icons.lock,
            isPassword: true,
          ),
        ],
      ),
    );
  }

//ตัวหนังสืออะตรงLogin
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixIcon: Icon(icon, color: Colors.white),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

//อันนี้ปุ่ม
  Widget _buildLoginBotton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () async {
                // เรียกใช้งานฟังก์ชัน Login
                String result = await FirebaseService.login(
                  _emailController.text,
                  _passwordController.text,
                );

                if (result == "Login successful") {
                  // ถ้า Login สำเร็จ ไปยังหน้า Dashboard
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                  );
                } else {
                  // แสดงข้อความ error
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  );
                }
              },
              child: Text(
                "Let's go see a movie!",
                style: GoogleFonts.bebasNeue(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

//อันนี้ถ้ายังไม่มีบัญชี
  // ignore: non_constant_identifier_names
  Widget _Signupage(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: TextButton(
            onPressed: () {
              // ไปที่หน้า Signup
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage()),
              );
            },
            child: Text(
              "ยังไม่มีบัญชีหรอครับ",
              style: GoogleFonts.bebasNeue(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _TextHomeLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'We meet again.',
            style: GoogleFonts.bebasNeue(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
