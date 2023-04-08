import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/register/molecules/register_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/colors.dart';

class RegisterOrganism extends StatelessWidget {
  const RegisterOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return CardAtom(
      color: QRColors.grey,
      child: FormRegisterMolecule(),
    );
  }
}
