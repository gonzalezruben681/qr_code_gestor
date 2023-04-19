import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/helper/modal.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/qr_scan/molecules/scan_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/contact_provider.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';

// ignore: must_be_immutable
class QRScanTemplate extends ConsumerStatefulWidget {
  const QRScanTemplate({super.key});

  @override
  ConsumerState<QRScanTemplate> createState() => _QRScanTemplateState();
}

class _QRScanTemplateState extends ConsumerState<QRScanTemplate> {
  BarcodeCapture? barcode;
  Contacto? contacto;

  Stream<List<OptionModel>>? _optionsStream;
  List<OptionModel>? _options;

  final MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _optionsStream = ref.read(optionProvider).getOptions();
    _optionsStream?.listen((optionsList) {
      setState(() {
        _options = optionsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final qrstr = ref.read(contactDataProvider.notifier);
    final contact = ref.read(contactProvider);
    // final opciones = ref.watch(optionProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
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
                style: GoogleFonts.itim(fontSize: 15, color: QRUtils.white),
              ),
            ),
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
                      content: ScanMolecule(
                        cameraController: cameraController,
                        onDetect: (barcode) async {
                          setState(() {
                            this.barcode = barcode;
                          });
                          qrstr.state = barcode.barcodes.first.rawValue ?? '';
                          contacto = await contact.callScan(qrstr.state);
                        },
                      ),
                      backgroundColor: QRUtils.white,
                      onPressed: () async {
                        Navigator.of(context).pop();
                        try {
                          cameraController.stop();
                        } on Exception catch (e) {
                          // ignore: use_build_context_synchronously
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
            ),
          ],
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
            itemCount: _options?.length,
            itemBuilder: (context, index) {
              final option = _options?[index];
              return Text('Opción: ${option?.option}');
            },
          ),
        ),
      ],
    );
  }
}
