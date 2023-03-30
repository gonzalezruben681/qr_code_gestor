// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:barcode_image/barcode_image.dart';
import 'package:qr_code_gestor/presentation/qr_scan.dart';
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
              data: 'nombre: $qrstr, telefono: $qrstrTel',
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
                    icon: Icons.download),
                const SizedBox(height: 15),
                _button(
                    text: 'ESCANEAR QR',
                    // Dentro del widget `FirstRoute`
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanScreen()),
                      );
                    },
                    icon: Icons.qr_code)
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
    final image = im.Image(250, 250);
    im.fill(image, im.getColor(255, 255, 255));
    drawBarcode(image, Barcode.qrCode(), 'nombre: $qrstr, telefono: $qrstrTel',
        font: im.arial_48);
    final data = im.encodePng(image);
    if (kIsWeb) {
      final fileName = '$qrstr.png';
      final path = await getSavePath(suggestedName: fileName);
      if (path != null) {
        final file = XFile.fromData(
          Uint8List.fromList(data),
          name: fileName,
          mimeType: 'image/png',
        );
        await file.saveTo(path);
      }
    } else {
// Convierte la imagen a un objeto Uint8List
      await ImageGallerySaver.saveImage(Uint8List.fromList(data),
          quality: 100, name: qrstr);
    }
  }
}
