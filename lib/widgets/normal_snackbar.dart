import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showNormalSnackbar(String message, BuildContext context) {
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
