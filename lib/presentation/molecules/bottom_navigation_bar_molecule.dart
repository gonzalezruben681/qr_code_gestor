import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class BottomNavigatorBarMolecule extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  const BottomNavigatorBarMolecule({
    super.key,
    required this.index,
    required this.onIndexSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: QRUtils.greyBackground),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonNavAtom(
                  text: 'Generar',
                  onPressed: () => onIndexSelected(1),
                  index: index,
                  pathIcon: 'assets/img/qr_code_2.png',
                  color: index == 1 ? QRUtils.yellowBackground : QRUtils.white,
                ),
                ButtonNavAtom(
                  text: 'Administrar',
                  onPressed: () => onIndexSelected(2),
                  index: index,
                  pathIcon: 'assets/img/editar.png',
                  color: index == 2 ? QRUtils.yellowBackground : QRUtils.white,
                ),
              ],
            ),
          ),
          Positioned(
            top: -0.3,
            child: FloatingActionButton(
              backgroundColor: QRUtils.yellowBackground,
              elevation: 5,
              onPressed: () => onIndexSelected(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                ),
                padding: const EdgeInsets.all(12.0),
                child: const Image(image: AssetImage('assets/img/qr_scan.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonNavAtom extends StatelessWidget {
  const ButtonNavAtom({
    super.key,
    required this.onPressed,
    required this.index,
    required this.pathIcon,
    this.color,
    required this.text,
  });

  final void Function()? onPressed;
  final int index;
  final String pathIcon;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image(
              image: AssetImage(pathIcon),
              color: color,
            ),
          ),
          Text(
            text,
            style: GoogleFonts.itim(color: color),
          ),
        ],
      ),
    );
  }
}
