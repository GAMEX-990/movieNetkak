import 'package:flutter/material.dart';
import 'package:fluttermovie/loginpage/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  static const Color _backgroundColor = Color.fromARGB(255, 1, 7, 21);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Create Account",
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      backgroundColor: _backgroundColor,
      bottom: _buildAppBarDivider(),
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

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: _backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildWelcomeText(),
            _buildInputFields(),
            _buildSignupButton(),
            _buildLoginLink(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        'Join us now!',
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Column(
        children: [
          _buildTextField(
            controller: _usernameController,
            label: 'Username',
            hint: 'Enter your username',
            icon: Icons.person,
          ),
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
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            hint: 'Confirm your password',
            icon: Icons.lock_clock,
            isPassword: true,
          ),
        ],
      ),
    );
  }

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
            hintStyle: TextStyle(color: Colors.white.withAlpha((0.5*255).round())),
            prefixIcon: Icon(icon, color: Colors.white),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: _handleSignup,
          child: Text(
            "Let's go see a movie!",
            style: GoogleFonts.bebasNeue(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "มีบัญชีอยู่หรือป่าว",
          style: GoogleFonts.bebasNeue(color: Colors.white),
        ),
      ),
    );
  }

void _handleSignup() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showMessage('กรุณากรอกข้อมูลให้ครบทุกช่อง');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('รหัสผ่านไม่ตรงกัน');
      return;
    }

    if (_passwordController.text.length < 6) {
      _showMessage('รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      _showMessage('รูปแบบอีเมลไม่ถูกต้อง');
      return;
    }

    try {
      String result = await FirebaseService.signup(
        _emailController.text.trim(),
        _passwordController.text,
        _usernameController.text.trim(),
      );

      _showMessage(result);

      if (result == "สมัครสมาชิกสำเร็จ") {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      _showMessage('เกิดข้อผิดพลาด: $e');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}