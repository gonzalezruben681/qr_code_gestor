import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGestorMobile extends StatefulWidget {
  const QRGestorMobile({super.key});

  @override
  State<QRGestorMobile> createState() => _QRGestorMobileState();
}

class _QRGestorMobileState extends State<QRGestorMobile> {
  String? qrstr;
  String? qrstrTel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (qrstr != null && qrstrTel != null)
            QrImage(
              data: 'nombre: $qrstr - telefono: $qrstrTel',
              size: 250,
            ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              children: [
                TextField(
                  onChanged: (val) {
                    setState(() {
                      qrstr = val.trim();
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Ingresa su nombre completo',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                ),
                const SizedBox(height: 15),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      qrstrTel = val.trim();
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'Ingresa su número de telefono',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2))),
                ),
                const SizedBox(height: 15),
                _button(
                    text: 'DESCARGAR QR',
                    onPressed: exportPng,
                    icon: Icons.download)
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }

  Widget _button(
      {IconData? icon, String? text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(text ?? ''),
        ],
      ),
    );
  }

  Future<void> exportPng() async {
    final qrCode = QrImage(
      data: 'Texto a codificar',
      version: QrVersions.auto,
      size: 200.0,
    );
    const imageSize = 200.0;

    final painter = QrPainter(
        data: 'nombre: $qrstr - telefono: $qrstrTel', version: qrCode.version);

// Convierte la imagen a un objeto Uint8List
    final pngBytes =
        await painter.toImageData(imageSize, format: ui.ImageByteFormat.png);
    final pngBytesList = pngBytes!.buffer.asUint8List();

// Guarda la imagen en la galería del dispositivo
    await ImageGallerySaver.saveImage(pngBytesList);
  }
}
