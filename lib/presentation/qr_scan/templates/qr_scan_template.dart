import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/helper/modal.dart';
import 'package:qr_code_gestor/helper/snackbar_notification.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/qr_scan/molecules/scan_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/contact_provider.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';

// ignore: must_be_immutable
class QRScanTemplate extends HookConsumerWidget {
  QRScanTemplate({super.key});

  ContactoModel? contacto;
  final MobileScannerController cameraController = MobileScannerController();
  late ContactoModel contactoModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrstr = ref.read(contactDataProvider.notifier);
    final contact = ref.read(contactProvider);
    final barcodeState = useState<BarcodeCapture?>(null);
    final selectedIndex = useState<int?>(null);
    final contactos = useState<List<ContactoModel>>([]);
    final options = useState<List<OptionModel>>([]);
    final optionsStream = ref.read(optionProvider).getOptions();
    final contactStream = ref.read(contactProvider).getContacts();

    useEffect(() {
      final subOpcion = optionsStream.listen((optionsList) {
        options.value = optionsList;
      });

      final subContacto = contactStream.listen((contactsList) {
        contactos.value = contactsList;
      });

      return () {
        cameraController.dispose();
        subOpcion.cancel;
        subContacto.cancel;
      };
    }, []);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 290,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
                          barcodeState.value = barcode;
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
                          SnackbarNotification.handleNotification(
                              message: 'ah ocurrido un Error! $e',
                              context: context,
                              color: Colors.red);
                        }
                      },
                    );
                    try {
                      cameraController.start();
                    } on Exception catch (e) {
                      SnackbarNotification.handleNotification(
                          message: 'ah ocurrido un Error! $e',
                          context: context,
                          color: Colors.red);
                    }
                  },
                  icon: Icons.qr_code),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Seleccione una opción:',
                style: GoogleFonts.itim(fontSize: 20, color: QRUtils.white),
              ),
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                itemCount: options.value.length,
                itemBuilder: (context, index) {
                  final option = options.value[index];
                  // return Text('Opción: ${option?.option}');
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: QRUtils.greyBackground.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                        ),
                      ],
                      color: QRUtils.greyBackground,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        selectedIndex.value = index;
                        if (contacto != null) {
                          contactoModel = ContactoModel(
                              nombre: contacto!.nombre,
                              telefono: contacto!.telefono,
                              idOpcion: option.id);
                          if (contactos.value.any((contact) =>
                              contact.nombre == contacto?.nombre &&
                              contact.idOpcion == option.id)) {
                            SnackbarNotification.handleNotification(
                                message: 'Este contacto ya existe',
                                context: context,
                                color: Colors.red);
                          } else {
                            contact.callAdd(contactoModel);
                            SnackbarNotification.handleNotification(
                                message: 'Se agrego correctamente',
                                context: context,
                                color: Colors.greenAccent);
                            contacto = null;
                            qrstr.state = '';
                          }
                        } else {
                          SnackbarNotification.handleNotification(
                              message:
                                  'Por favor primero escanear el QR y luego seleccionar una opción',
                              context: context,
                              color: Colors.red);
                        }
                      },
                      title: Text(
                        option.option,
                        style: GoogleFonts.itim(
                          color: QRUtils.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
