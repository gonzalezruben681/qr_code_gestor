import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/qr_gestor/molecules/qr_gestor_molecule.dart';

class QRGestorOrganism extends StatelessWidget {
  const QRGestorOrganism({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (nombre != null && telefono != null)
          //   QrImage(
          //   data: 'nombre: ${nombre!.trim()}, telefono: ${telefono!.trim()}',
          //   size: 250,
          // ),
          QRGestorMolecule(),
        ],
      ),
    );
  }
}
