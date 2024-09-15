import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/auth/login/organisms/login_organism.dart';
import 'package:qr_code_gestor/presentation/molecules/background_molecule.dart';

class LoginTemplate extends StatelessWidget {
  const LoginTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundPageMolecule(),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/icon/qr.png',
                    ),
                  ),
                  const SizedBox(height: 50),
                  const LoginOrganism(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
