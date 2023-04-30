import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/domain/models/opcion.dart';
import 'package:qr_code_gestor/helper/snackbar_notification.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/providers/option_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddOptionMolecule extends HookConsumerWidget {
  AddOptionMolecule({super.key});

  // validaciones del formulario
  final form = FormGroup({
    'opcion': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
    ]),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opciones = useState<List<OptionModel>>([]);

    final options = ref.watch(optionProvider);
    final optionsStream = options.getOptions();

    useEffect(() {
      final subcOpcion = optionsStream.listen((optionsList) {
        opciones.value = optionsList;
      });
      return () {
        subcOpcion.cancel;
      };
    }, []);

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
                FocusScope.of(context).unfocus();
                if (form.invalid) {
                  form.markAllAsTouched();
                  return;
                }

                final opcion = form.control('opcion').value!;
                if (opciones.value
                    .any((op) => op.option.toLowerCase() == opcion)) {
                  SnackbarNotification.handleNotification(
                      message: 'Esa opción ya existe',
                      context: context,
                      color: Colors.red[300]);
                  return;
                }
                final opction = await options.addOption(opcion);
                if (opction) {
                  // ignore: use_build_context_synchronously
                  SnackbarNotification.handleNotification(
                      context: context,
                      message: 'Se agrego correctamente la opción',
                      color: QRUtils.greyBackground);
                  form.control('opcion').reset();
                } else {
                  // ignore: use_build_context_synchronously
                  SnackbarNotification.handleNotification(
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
