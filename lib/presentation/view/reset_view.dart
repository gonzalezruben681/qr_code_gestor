import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/auth/reset_password/templates/reset_template.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class ResetView extends StatelessWidget {
  const ResetView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: QRUtils.greyBackground,
      body: ResetPasswordTemplate(),
    );
  }
}
