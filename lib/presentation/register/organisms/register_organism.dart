import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/register/molecules/register_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class RegisterOrganism extends StatelessWidget {
  const RegisterOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardAtom(
            color: QRUtils.greyBackground.withOpacity(0.8),
            child: Column(
              children: [
                FormRegisterMolecule(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
