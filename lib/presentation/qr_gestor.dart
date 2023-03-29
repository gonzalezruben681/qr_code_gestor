// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRGestor extends StatefulWidget {
  const QRGestor({super.key});

  @override
  State<QRGestor> createState() => _QRGestorState();
}

class _QRGestorState extends State<QRGestor> {
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
    if (kIsWeb) {
      final pngBytes = await painter.toImageData(imageSize);

// Crea un objeto Blob con los bytes de la imagen
      final blob = html.Blob([pngBytes], 'image/png');

// Crea un objeto URL a partir del Blob
      final url = html.Url.createObjectUrlFromBlob(blob);

// Crea un enlace de descarga y haz clic en él para iniciar la descarga
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..download = '$qrstr.png';
      html.document.body!.append(anchor);
      anchor.click();

// Libera el objeto URL y el Blob de la memoria
      html.Url.revokeObjectUrl(url);
    } else {
      final painter = QrPainter(
          data: 'nombre: $qrstr - telefono: $qrstrTel',
          version: qrCode.version);

// Convierte la imagen a un objeto Uint8List
      final pngBytes =
          await painter.toImageData(imageSize, format: ui.ImageByteFormat.png);
      final pngBytesList = pngBytes!.buffer.asUint8List();

// Guarda la imagen en la galería del dispositivo
      await ImageGallerySaver.saveImage(pngBytesList);
    }
  }
}
