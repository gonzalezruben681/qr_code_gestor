import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/register/organisms/register_organism.dart';

class RegisterTemplate extends StatelessWidget {
  const RegisterTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          RegisterOrganism(),
        ],
      ),
    );
  }
}
