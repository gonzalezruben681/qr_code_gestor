import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/login/templates/login_template.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: QRUtils.greyBackground,
      body: LoginTemplate(),
    );
  }
}
