import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'role_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isEmail = true;

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }

  void login() {
    if (isEmail) {
      if (email.text.isNotEmpty && password.text.isNotEmpty) {

        // 🔥 LOGIN SUCCESS → ROLE PAGE
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const RoleSelectionScreen(),
          ),
        );

      } else {
        showMsg("Enter Email & Password");
      }
    } else {
      if (phone.text.length == 10) {

        // 🔥 GO TO OTP
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPScreen(
              phone: phone.text,
            ),
          ),
        );

      } else {
        showMsg("Enter valid phone number");
      }
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool isPassword = false,
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8F8F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
          ),
        ),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [

                      const Icon(Icons.agriculture, size: 60, color: Colors.white),
                      const SizedBox(height: 10),

                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [

                            isEmail
                                ? Column(
                                    children: [
                                      buildTextField(
                                        controller: email,
                                        hint: "Enter Email",
                                        icon: Icons.email,
                                      ),
                                      const SizedBox(height: 15),
                                      buildTextField(
                                        controller: password,
                                        hint: "Enter Password",
                                        icon: Icons.lock,
                                        isPassword: true,
                                      ),
                                    ],
                                  )
                                : buildTextField(
                                    controller: phone,
                                    hint: "Enter Phone Number",
                                    icon: Icons.phone,
                                    type: TextInputType.phone,
                                  ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: login,
                                child: const Text("Login"),
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEmail = !isEmail;
                                });
                              },
                              child: Text(
                                isEmail
                                    ? "Login with Phone"
                                    : "Login with Email",
                                style: const TextStyle(color: Color(0xFF2E7D32)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}