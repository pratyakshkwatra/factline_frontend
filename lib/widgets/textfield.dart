import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController controller;
  final int? maxLines;

  const RoundedInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.merriweather(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
        hintText: hintText,
        hintStyle: GoogleFonts.merriweather(color: Colors.black),
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
