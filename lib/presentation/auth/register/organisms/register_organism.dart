import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/auth/register/molecules/register_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class RegisterOrganism extends StatelessWidget {
  const RegisterOrganism({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_rounded,
                            size: 40, color: QRUtils.yellowBackground)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Crear Usuario ',
                      style: GoogleFonts.itim(
                        color: QRUtils.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                FormRegisterMolecule(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
