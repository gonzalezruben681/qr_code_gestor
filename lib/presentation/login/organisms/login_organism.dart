import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/login/molecules/login_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/colors.dart';

class LoginOrganism extends StatelessWidget {
  const LoginOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return CardAtom(
      color: QRColors.grey,
      child: Column(
        children: [
          FormMolecule(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                text: 'Registro'),
          ),
        ],
      ),
    );
  }
}
