import 'package:auto_route/auto_route.dart';
import 'package:factline/api/exceptions.dart';
import 'package:factline/api/models/user.dart';
import 'package:factline/router/router.gr.dart';
import 'package:factline/services/auth.dart';
import 'package:factline/widgets/error_snackbar.dart';
import 'package:factline/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  final AuthService authService;
  final FlutterSecureStorage secureStorage;
  const LoginScreen({
    super.key,
    required this.authService,
    required this.secureStorage,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      User? user = await widget.authService.login(_email.text, _password.text);
      if (mounted) {
        if (user != null) {
          context.router.push(
            HomeRoute(
              authService: widget.authService,
              secureStorage: widget.secureStorage,
              user: user,
            ),
          );
        }
      }
    } on APIException catch (e) {
      if (mounted) {
        showErrorSnackbar("${e.code}: ${e.message}", context);
      }
    } catch (error) {
      if (mounted) {
        showErrorSnackbar("Unexpected error. Please try again.", context);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.black;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Icon(Icons.lock_outline, size: 64, color: primaryColor),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.merriweather(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to your account',
                      style: GoogleFonts.merriweather(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 32),
                    RoundedInputField(
                      controller: _email,
                      hintText: 'Email',
                      icon: Icons.person,
                      isPassword: false,
                    ),
                    const SizedBox(height: 16),
                    RoundedInputField(
                      controller: _password,
                      hintText: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),
                    _RoundedButton(
                      label: 'Login',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? null : _login,
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?  ",
                          style: GoogleFonts.merriweather(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.router.push(
                              CreateAccountRoute(
                                authService: widget.authService,
                                secureStorage: widget.secureStorage,
                              ),
                            );
                          },
                          child: Text(
                            'Create one',
                            style: GoogleFonts.merriweather(
                              color: Colors.black,
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
      ),
    );
  }
}

class _RoundedButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _RoundedButton({
    required this.label,
    required this.color,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed == null ? color.withValues(alpha: 0.6) : color,
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  label,
                  style: GoogleFonts.merriweather(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
