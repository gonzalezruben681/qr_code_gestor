import 'package:flutter/material.dart';

class SnackbarNotification {
  static handleNotification(
      {required BuildContext context, dynamic message, Color? color}) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(message ?? ''),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
