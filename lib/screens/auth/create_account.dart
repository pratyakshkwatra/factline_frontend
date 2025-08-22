import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:factline/api/exceptions.dart' show APIException;
import 'package:factline/services/auth.dart';
import 'package:factline/widgets/button.dart';
import 'package:factline/widgets/error_snackbar.dart';
import 'package:factline/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class CreateAccountScreen extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  const CreateAccountScreen({
    super.key,
    required this.authService,
    required this.secureStorage,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

bool _isLoading = false;

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: GoogleFonts.poppins(color: Colors.white)),
      backgroundColor: Colors.deepPurpleAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Colors.black;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, size: 64, color: primary),
                  const SizedBox(height: 16),
                  Text(
                    'Create Account',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign up to get started',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  RoundedInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  RoundedInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  RoundedButton(
                    label: 'Create',
                    color: primary,
                    isLoading: _isLoading,
                    onPressed: _isLoading
                        ? () {}
                        : () async {
                            setState(() => _isLoading = true);
                            try {
                              await widget.authService
                                  .register(
                                    _emailController.text,
                                    _passwordController.text,
                                  )
                                  .then((dynamic value) {
                                    _showMessage(
                                      "You'll be redirected to Log-In in 3 seconds",
                                    );
                                    Timer(const Duration(seconds: 3), () {
                                      if (context.mounted) {
                                        context.router.pop();
                                      }
                                    });
                                  });
                            } on APIException catch (exception) {
                              if (context.mounted) {
                                showErrorSnackbar(
                                  "${exception.code}: ${exception.message}",
                                  context,
                                );
                              }
                            } catch (_) {
                              if (context.mounted) {
                                showErrorSnackbar(
                                  "Unexpected error. Please try again.",
                                  context,
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
                          },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?  ",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            color: primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
