import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_gestor/helper/modal.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/molecules/scanner_error_widget.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/presentation/view/qr_scanner_overray.dart';

class QRScanWiew extends StatefulWidget {
  const QRScanWiew({super.key});

  @override
  State<QRScanWiew> createState() => _QRScanWiewState();
}

class _QRScanWiewState extends State<QRScanWiew> {
  String qrstr = '';
  BarcodeCapture? barcode;
  Contacto? contacto;
  final MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 290,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: QRUtils.white,
              width: 0.50,
            ),
            color: QRUtils.greyBackground,
          ),
          child: Text(
            'nombre: ${contacto?.nombre ?? ''}',
            style: GoogleFonts.itim(color: QRUtils.white, fontSize: 20),
          ),
        ),
        // Text(
        //   'nombre: ${contacto?.nombre ?? ''}, telefono: ${contacto?.telefono ?? ''}',
        //   style: const TextStyle(color: Colors.blue, fontSize: 30),
        // ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: CustomButtonAtom(
              style: GoogleFonts.itim(
                fontSize: 20,
              ),
              text: 'ESCANEAR QR',
              onPressed: () {
                mostrarModal(
                  context: context,
                  content: scanQrWeb(context),
                  backgroundColor: QRUtils.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                    try {
                      cameraController.stop();
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ah ocurrido un Error! $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                );
                try {
                  cameraController.start();
                } on Exception catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('ah ocurrido un Error! $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              icon: Icons.qr_code),
        )
      ],
    );
  }

  Widget scanQrWeb(BuildContext context) {
    return SizedBox(
      height: 271,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 223,
                width: 223,
                child: MobileScanner(
                  controller: cameraController,
                  errorBuilder: (context, error, child) {
                    return ScannerErrorWidget(error: error);
                  },
                  fit: BoxFit.cover,
                  onDetect: (barcode) {
                    setState(() {
                      this.barcode = barcode;
                    });
                    qrstr = barcode.barcodes.first.rawValue ?? '';
                    scanQr(qrstr);
                  },
                ),
              ),
              QRScannerOverlay(
                overlayColour: Colors.black.withOpacity(0.2),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.black,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.torchState,
                  builder: (context, state, child) {
                    switch (state) {
                      case TorchState.off:
                        return const Icon(Icons.flash_off, color: Colors.grey);
                      case TorchState.on:
                        return const Icon(Icons.flash_on, color: Colors.yellow);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.toggleTorch(),
              ),
              IconButton(
                color: Colors.black,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front);
                      case CameraFacing.back:
                        return const Icon(Icons.camera_rear);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> scanQr(String qrstr) async {
    try {
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
