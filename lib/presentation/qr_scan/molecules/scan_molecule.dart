import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/presentation/view/qr_scanner_overray.dart';
import 'package:qr_code_gestor/providers/contact_provider.dart';

import '../../molecules/scanner_error_widget.dart';

class ScanMolecule extends HookConsumerWidget {
  ScanMolecule({
    super.key,
  });

  final MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.unrestricted);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final contacto = ref.watch(contactDataProvider);
    final qrstrPrint = ref.watch(contactDataProvider);
    final barcodeState = useState<BarcodeCapture?>(null);

    return SizedBox(
      height: 325,
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
                    barcodeState.value = barcode;
                    ref.read(contactDataProvider.notifier).state =
                        barcodeState.value?.barcodes.first.rawValue ?? '';
                    // debugPrint('Barcode found! $qrstrPrint');
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
          Column(
            children: [
              Text(
                'Contacto:',
                style: GoogleFonts.itim(
                    fontSize: 15, color: QRUtils.greyBackground),
              ),
              Text(
                qrstrPrint,
                style: GoogleFonts.itim(
                    fontSize: 15, color: QRUtils.greyBackground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
