// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/helper/snackbar_notification.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';

import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

// ignore: must_be_immutable
class FormResetPasswordMolecule extends HookConsumerWidget {
  FormResetPasswordMolecule({super.key});

  late String email;

// validaciones del formulario
  final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(firebaseAuthProvider);
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          Text(
            'Recupera tu cuenta',
            style: GoogleFonts.itim(
              color: QRUtils.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
          CustomInputAtom(
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            icon: Icons.supervised_user_circle,
            keyboardType: TextInputType.emailAddress,
            placeholder: 'Ingresa tu email',
            formControlName: 'email',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.email: (error) => 'Ingrese un email correcto',
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
              text: 'Enviar',
              style:
                  GoogleFonts.itim(fontSize: 20, color: QRUtils.greyBackground),
              onPressed: () async {
                // FocusScope.of(context).unfocus();
                if (form.invalid) {
                  form.markAllAsTouched();
                  return;
                }

                email = form.control('email').value!;

                final authResetPassword =
                    await authRepository.sendResetPasswordLink(email);
                if (authResetPassword != null) {
                  SnackbarNotification.handleNotification(
                      // ignore: use_build_context_synchronously
                      context: context,
                      message:
                          'el email es incorrecto o aun no esta registrado $authResetPassword',
                      color: Colors.red);
                } else {
                  SnackbarNotification.handleNotification(
                      // ignore: use_build_context_synchronously
                      context: context,
                      message: 'el email fue enviado',
                      color: Colors.green);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
