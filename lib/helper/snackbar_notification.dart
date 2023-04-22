import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class SnackbarNotification {
  static handleNotification(
      {required BuildContext context, dynamic message, Color? color}) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message ?? '',
        style: GoogleFonts.itim(fontSize: 20, color: QRUtils.white),
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
