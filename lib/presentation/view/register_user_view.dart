import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/register/templates/register_template.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: QRUtils.greyBackground,
      body: RegisterTemplate(),
    );
  }
}
