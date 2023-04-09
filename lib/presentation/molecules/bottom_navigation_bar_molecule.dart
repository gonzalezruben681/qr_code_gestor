import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class BottomNavigatorBarMolecule extends StatelessWidget {
  const BottomNavigatorBarMolecule({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: QRUtils.greyBackground),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                    width: 30,
                    child: Image(
                      image: AssetImage('assets/img/qr_code_2.png'),
                    ),
                  ),
                  Text(
                    'Generar',
                    style: GoogleFonts.itim(color: QRUtils.white),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                    width: 30,
                    child: Image(
                      image: AssetImage('assets/img/editar.png'),
                    ),
                  ),
                  Text(
                    'Administrar',
                    style: GoogleFonts.itim(color: QRUtils.white),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
