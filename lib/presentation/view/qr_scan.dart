import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';

class QRScanWiew extends StatefulWidget {
  const QRScanWiew({super.key});

  @override
  State<QRScanWiew> createState() => _QRScanWiewState();
}

class _QRScanWiewState extends State<QRScanWiew> {
  String qrstr = '';
  Contacto? contacto;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanning QR code'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'nombre: ${contacto?.nombre ?? ''}, telefono: ${contacto?.telefono ?? ''}',
                style: const TextStyle(color: Colors.blue, fontSize: 30),
              ),
              ElevatedButton(onPressed: scanQr, child: const Text(('Scanner'))),
              SizedBox(
                height: width,
              )
            ],
          ),
        ));
  }

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode(
              '#2A99CF', 'cancelar', true, ScanMode.QR)
          .then((value) {
        setState(() {
          qrstr = value;
        });
      });

      if (qrstr.isNotEmpty) {
        // Parsear el mensaje para obtener un mapa
        Map<String, dynamic> mapa = Map.fromEntries(qrstr.split(',').map((s) {
          final List<String> parts = s.trim().split(':');
          return MapEntry(parts[0], parts[1]);
        }));

        // Crear un nuevo objeto de la clase Contacto a partir del mapa
        contacto = Contacto.fromJson(mapa);
      }
    } catch (e) {
      setState(() {
        qrstr = 'unable to read this';
      });
    }
  }
}
