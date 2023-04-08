import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/login/organisms/login_organism.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          LoginOrganism(),
        ],
      ),
    );
  }
}
