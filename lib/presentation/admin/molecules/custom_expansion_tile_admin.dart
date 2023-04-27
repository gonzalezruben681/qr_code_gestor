import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/domain/models/contacto.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/helper/modal.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/contact_provider.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ContactExpansionTileMolecule extends HookConsumerWidget {
  const ContactExpansionTileMolecule({
    super.key,
    this.index,
    required this.option,
  });
  final int? index;
  final OptionModel? option;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState<int?>(null);
    final contacts = useState<List<ContactoModel>>([]);
    final contactsStream = ref.watch(contactProvider).getContacts();
    final options = ref.watch(optionProvider);

    // validaciones del formulario
    final form = fb.group(<String, Object>{
      'opcion': FormControl<String>(validators: [
        Validators.required,
        Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
      ], value: option?.option),
    });

    useEffect(() {
      final subscription = contactsStream.listen((contactos) {
        contacts.value = contactos;
      });

      return () {
        subscription.cancel;
      };
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: selectedIndex.value == index ? 330 : 50,
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
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    option?.option ?? '',
                    style: GoogleFonts.itim(
                      color: QRUtils.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        mostrarModal(
                            context: context,
                            backgroundColor: QRUtils.greyBackground,
                            onPressed: () async {
                              if (form.invalid) {
                                form.markAllAsTouched();
                                return;
                              }
                              await options.updateOption(OptionModel(
                                  id: option!.id,
                                  option: form.control('opcion').value!));
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  Text(
                                    'Editar opción',
                                    style: GoogleFonts.itim(
                                      color: QRUtils.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ReactiveForm(
                                    formGroup: form,
                                    child: Column(
                                      children: [
                                        CustomInputAtom(
                                          formControlName: 'opcion',
                                          placeholder:
                                              'Ingrese la opción a editar',
                                          enabled: true,
                                          style: GoogleFonts.itim(
                                            fontSize: 20,
                                          ),
                                          validationMessages: {
                                            ValidationMessage.required:
                                                (error) =>
                                                    'Este campo es requerido',
                                            ValidationMessage.pattern: (errror) =>
                                                'Solo se permiten letras, comas y espacios',
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      icon: const Icon(
                        Icons.edit_document,
                        color: QRUtils.white,
                      ),
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      onPressed: () {
                        modalOptions(context);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: QRUtils.white,
                      ),
                      tooltip: 'Borrar',
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
              ],
            ),
            Expanded(
              child: AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: SizedBox(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Lista de contactos:',
                          style: GoogleFonts.itim(
                              fontSize: 20, color: QRUtils.white),
                        ),
                      ),
                      Expanded(
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
                    ],
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

  Future<dynamic> modalOptions(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        icon: const Icon(
          Icons.delete_forever,
          color: Colors.redAccent,
          size: 30,
        ),
        backgroundColor: QRUtils.greyBackground,
        title: Text('Eliminar opción',
            style: GoogleFonts.itim(
                color: QRUtils.yellowBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        content: Text('¿Deseas eliminar esta opción?',
            style: GoogleFonts.itim(
              color: QRUtils.white,
              fontSize: 20,
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text(
                  'Cancelar',
                  style: GoogleFonts.itim(
                    color: QRUtils.yellowBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              CustomButtonAtom(
                text: 'Aceptar',
                style: GoogleFonts.itim(
                  color: QRUtils.greyBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
