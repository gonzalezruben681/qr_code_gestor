import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/auth/register/organisms/register_organism.dart';
import 'package:qr_code_gestor/presentation/molecules/background_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class RegisterTemplate extends StatelessWidget {
  const RegisterTemplate({super.key});

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
                  const SizedBox(height: 50),
                  Center(
                    child: Image.asset(
                      'assets/icon/qr.png',
                    ),
                  ),
                  const SizedBox(height: 50),
                  const RegisterOrganism(),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded,
                  size: 40, color: QRUtils.yellowBackground)),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
