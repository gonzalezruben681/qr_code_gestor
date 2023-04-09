import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/register/molecules/register_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class RegisterOrganism extends StatelessWidget {
  const RegisterOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return CardAtom(
      color: QRUtils.grey,
      child: FormRegisterMolecule(),
    );
  }
}
