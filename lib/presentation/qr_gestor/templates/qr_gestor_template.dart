import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/qr_gestor/organisms/qr_gestor_organism.dart';

class QRGestorTemplate extends StatelessWidget {
  const QRGestorTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: QRGestorOrganism(),
    );
  }
}
