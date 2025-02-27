import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:uasflutter/pages/login/login.dart';
import 'package:uasflutter/services/auth_services.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[900], // Dark background for cool effect
    resizeToAvoidBottomInset: true,
    bottomNavigationBar: _signin(context),
    body: SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              // Cool 3D Animated Title
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutBack,
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.5 * value)
                      ..rotateY(0.5 * value)
                      ..translate(0.0, -50 * (1 - value)), // Slide up effect
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        'Register Account',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 42,
                            shadows: [
                              Shadow(
                                blurRadius: 20.0,
                                color: Colors.blue.withOpacity(0.8),
                                offset: const Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // Floating 3D Lottie Animation
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutBack,
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.3 * value)
                      ..rotateY(0.3 * value)
                      ..translate(0.0, -50 * (1 - value)), // Floating effect
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value,
                      child: Lottie.asset(
                        'assets/tes.json',
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // 3D Email Input Field
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOutBack,
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.2 * value)
                      ..rotateY(0.2 * value)
                      ..translate(0.0, -20 * (1 - value)), // Slide up effect
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value,
                      child: _emailAddress(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // 3D Password Input Field
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOutBack,
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.2 * value)
                      ..rotateY(0.2 * value)
                      ..translate(0.0, -20 * (1 - value)), // Slide up effect
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value,
                      child: _password(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),

              // Cool 3D Signup Button
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOutBack,
                builder: (context, double value, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(0.3 * value)
                      ..rotateY(0.3 * value)
                      ..translate(0.0, -20 * (1 - value)), // Slide up effect
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: value,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(double.infinity, 60),
                          elevation: 10,
                          shadowColor: Colors.blue.withOpacity(0.5),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await AuthService().signup(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 254, 254),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.1),
          alignment: Alignment.center,
          child: TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!isValidEmail(value)) {
                return 'Format email tidak valid';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'masukkan email anda!',
              hintStyle: const TextStyle(
                color: Color(0xff6A6A6A),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              fillColor: const Color.fromARGB(255, 225, 225, 255),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.1),
          alignment: Alignment.center,
          child: TextFormField(
            controller: _passwordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password tidak boleh kosong';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              hintText: 'masukkan password anda!',
              hintStyle: const TextStyle(
                color: Color(0xff6A6A6A),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              fillColor: const Color.fromARGB(255, 225, 225, 255),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(0.1),
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff0D6EFD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          minimumSize: const Size(double.infinity, 60),
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await AuthService().signup(
              email: _emailController.text,
              password: _passwordController.text,
              context: context,
            );
          }
        },
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          const TextSpan(
            text: "Already Have Account? ",
            style: TextStyle(
              color: Color(0xff6A6A6A),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: "Log In",
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
          ),
        ]),
      ),
    );
  }
}