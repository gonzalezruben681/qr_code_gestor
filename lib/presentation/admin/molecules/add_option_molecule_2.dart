import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/helper/snackbar_notification.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddOptionMolecule2 extends ConsumerStatefulWidget {
  const AddOptionMolecule2({super.key});

  @override
  ConsumerState<AddOptionMolecule2> createState() => _AddOptionMolecule2State();
}

class _AddOptionMolecule2State extends ConsumerState<AddOptionMolecule2> {
  // validaciones del formulario
  final form = FormGroup({
    'opcion': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
    ]),
  });

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final options = ref.read(optionProvider);
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          CustomInputAtom(
            formControlName: 'opcion',
            placeholder: 'Ingrese la pregunta o opción',
            enabled: true,
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.pattern: (errror) =>
                  'Solo se permiten letras, comas y espacios',
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
              style:
                  GoogleFonts.itim(fontSize: 20, color: QRUtils.greyBackground),
              text: 'Agregar',
              onPressed: () async {
                if (form.invalid) {
                  form.markAllAsTouched();
                  return;
                }

                final opcion = form.control('opcion').value!;
                final opction = await options.addOption(opcion);
                if (opction) {
                  SnackbarNotification.handleNotification(
                  // ignore: use_build_context_synchronously
                      context: context,
                      message: 'Se agrego correctamente la opción',
                      color: Colors.greenAccent);
                  form.control('opcion').reset();
                } else {
                  SnackbarNotification.handleNotification(
                  // ignore: use_build_context_synchronously
                      context: context,
                      message:
                          'Hubo un error al agregar la opción, intente de nuevo',
                      color: Colors.red);
                }
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
