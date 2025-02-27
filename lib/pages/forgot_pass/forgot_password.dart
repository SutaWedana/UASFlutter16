// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'package:uasflutter/pages/login/widgets/snackbar.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.raleway(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lottie Animation
            Lottie.asset(
              'assets/riset.json', // Ganti dengan path file JSON Anda
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            // Description Text
            Text(
              'Enter your email address and we will send you a link to reset your password.',
              style: GoogleFonts.raleway(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Email Input Field
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Email Address",
                  hintText: "Masukkan email anda!",
                  labelStyle: GoogleFonts.raleway(),
                  hintStyle: GoogleFonts.raleway(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 24),

            // Reset Password Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () async {
                  if (emailController.text.trim().isEmpty) {
                    showSnackBar(context, "Tolong input email anda!");
                    return;
                  }
                  try {
                    await auth.sendPasswordResetEmail(
                      email: emailController.text.trim(),
                    );
                    showSnackBar(
                      context,
                      "Link reset password telah dikirim ke email anda!",
                    );
                    Navigator.pop(context);
                  } catch (error) {
                    showSnackBar(context, error.toString());
                  }
                },
                child: Text(
                  'Reset Password',
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}