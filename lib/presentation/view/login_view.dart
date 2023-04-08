import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/login/templates/login_template.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2f2F2),
      appBar: AppBar(title: const Text('Registro usuario')),
      body: const LoginTemplate(),
    );
  }
}
