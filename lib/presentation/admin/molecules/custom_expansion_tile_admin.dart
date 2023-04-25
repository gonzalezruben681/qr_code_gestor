import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/contact_provider.dart';

class ContactExpansionTileMolecule extends HookConsumerWidget {
  const ContactExpansionTileMolecule({
    Key? key,
    this.index,
    required this.option,
  }) : super(key: key);
  final int? index;
  final OptionModel? option;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int?>(null);
    final contacts = useState<List<ContactoModel>>([]);
    final contactsStream = ref.watch(contactProvider).getContacts();

    useEffect(() {
      final subscription = contactsStream.listen((contactos) {
        contacts.value = contactos;
      });
      return subscription.cancel;
    }, []);

    void filterContactsByOption(String idOpcion) {
      if (idOpcion == 'Todos') {
        contacts.value;
      } else {
        contacts.value = contacts.value
            .where((contact) => contact.idOpcion == idOpcion)
            .toList();
      }
    }

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        selectedIndex.value = selectedIndex.value == index ? null : index;
        filterContactsByOption(option?.id ?? 'Todos');
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: selectedIndex.value == index ? 12 : 0,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: selectedIndex.value == index ? 108 : 50,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: QRUtils.greyBackground.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: QRUtils.greyBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(selectedIndex.value == index ? 10 : 20),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  option?.option ?? '',
                  style: GoogleFonts.itim(
                    color: QRUtils.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  selectedIndex.value == index
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: QRUtils.white,
                  size: 27,
                ),
              ],
            ),
            // selectedIndex == index
            //     ? const SizedBox()
            //     : const SizedBox(height: 20),
            Expanded(
              child: AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: contacts.value.length,
                    itemBuilder: (context, index) {
                      final contact = contacts.value[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text('Nombre: ',
                                style: GoogleFonts.itim(
                                  color: QRUtils.yellowBackground,
                                )),
                            Text(contact.nombre,
                                style: GoogleFonts.itim(
                                  color: QRUtils.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text('Teléfono: ',
                                style: GoogleFonts.itim(
                                  color: QRUtils.yellowBackground,
                                )),
                            Text(
                              contact.telefono,
                              style: GoogleFonts.itim(
                                color: QRUtils.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                crossFadeState: selectedIndex.value == index
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 1200),
                reverseDuration: Duration.zero,
                sizeCurve: Curves.fastLinearToSlowEaseIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
