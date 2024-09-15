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

  late ContactoModel contactoModel;
  final nameController = TextEditingController();
  final MobileScannerController cameraController = MobileScannerController(
    torchEnabled: true,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrstr = ref.watch(contactDataProvider.notifier);

    final contact = ref.read(contactProvider);
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
        subOpcion.cancel();
        subContacto.cancel();
      };
    }, []);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 120),
            Container(
                height: 40,
                width: 300,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: QRUtils.white,
                    width: 0.50,
                  ),
                  color: QRUtils.greyBackground,
                ),
                child: Row(
                  children: [
                    Text(
                      'Nombre:',
                      style: GoogleFonts.itim(
                          fontSize: 15, color: QRUtils.yellowBackground),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: TextField(
                          controller: nameController,
                          enabled: false,
                          style: GoogleFonts.itim(
                              fontSize: 15, color: QRUtils.white),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                )),
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
                      content: ScanMolecule(),
                      backgroundColor: QRUtils.white,
                      onPressed: () {
                        Navigator.pop(context);

                        if (qrstr.state.isNotEmpty) {
                          // Utilizar una expresión regular para mantener solo los caracteres deseados
                          final sanitizedString = qrstr.state.replaceAll(
                              RegExp(r'[^,:áéíóúÁÉÍÓÚA-Za-z0-9\s]'), '');

                          List<String> parts = sanitizedString.split(',');
                          if (parts.length >= 2) {
                            Map<String, dynamic> mapa =
                                Map.fromEntries(parts.map((s) {
                              final List<String> subparts = s.trim().split(':');
                              if (subparts.length == 2) {
                                return MapEntry(subparts[0], subparts[1]);
                              }
                              // Puedes manejar el caso donde no haya suficientes elementos.
                              return const MapEntry('',
                                  ''); // O cualquier valor predeterminado que desees.
                            }));
                            if (mapa.containsKey('nombre') &&
                                mapa.containsKey('telefono')) {
                              contacto = ContactoModel.fromJson(mapa);
                              nameController.text = contacto!.nombre;
                            } else {
                              qrstr.state = '';
                            }
                            // Parsear el mensaje para obtener un mapa
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      },
                    );
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
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView.builder(
                itemCount: options.value.length,
                itemBuilder: (context, index) {
                  final option = options.value[index];
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
                      onTap: () async {
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
                            await contact.addContact(contactoModel);
                            SnackbarNotification.handleNotification(
                            // ignore: use_build_context_synchronously
                                context: context,
                                message: 'Se agrego correctamente',
                                color: Colors.greenAccent);
                            qrstr.state = '';
                            contacto = null;
                            nameController.clear();
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
