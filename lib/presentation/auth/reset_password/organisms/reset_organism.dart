import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/auth/reset_password/molecules/form_reset_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class ResetPasswordOrganism extends StatelessWidget {
  const ResetPasswordOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardAtom(
            color: QRUtils.greyBackground.withOpacity(0.8),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        size: 40, color: QRUtils.yellowBackground)),
                FormResetPasswordMolecule(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
