import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/presentation/atoms/card_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/auth/login/molecules/form_login_molecule.dart';

class LoginOrganism extends StatelessWidget {
  const LoginOrganism({super.key});

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
                FormMolecule(),
                TextButton(
                    onPressed: () => Navigator.pushNamed(
                        context, '/reset_password'),
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: GoogleFonts.itim(
                          fontSize: 20, color: QRUtils.yellowBackground),
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
                style: GoogleFonts.itim(
                    fontSize: 20, color: QRUtils.greyBackground),
                onPressed: () => Navigator.pushNamed(context, '/register'),
                text: 'Registro'),
          ),
        ],
      ),
    );
  }
}
