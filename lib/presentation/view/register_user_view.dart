import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/register/templates/register_template.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2f2F2),
      appBar: AppBar(title: const Text('Registro usuario')),
      body: const RegisterTemplate(),
    );
  }
}
