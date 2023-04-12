import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/login/organisms/login_organism.dart';
import 'package:qr_code_gestor/presentation/molecules/background_molecule.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        BackgroundPageMolecule(),
        SingleChildScrollView(
          child: LoginOrganism(),
        ),
      ],
    );
  }
}
