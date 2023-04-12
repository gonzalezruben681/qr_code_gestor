// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';

import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

// ignore: must_be_immutable
class FormRegisterMolecule extends HookConsumerWidget {
  FormRegisterMolecule({super.key});
  late String nombre;
  late String email;
  late String password;

// validaciones del formulario
  final form = FormGroup({
    'name': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(r'^[a-zA-ZñÑ,\sáéíóúÁÉÍÓÚ]+$'),
    ]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
      Validators.maxLength(18),
      Validators.minLength(6),
    ]),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(true);
    final authRepository = ref.read(firebaseAuthProvider);
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          Text(
            'Crear Usuario ',
            style: GoogleFonts.itim(
              color: QRUtils.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          CustomInputAtom(
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            formControlName: 'name',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.pattern: (errror) =>
                  'Solo se permiten letras, comas y espacios',
            },
          ),
          CustomInputAtom(
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            icon: Icons.supervised_user_circle,
            placeholder: 'Email',
            formControlName: 'email',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.email: (error) => 'Ingrese un email correcto',
            },
          ),
          CustomInputAtom(
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            formControlName: 'password',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.maxLength: (error) =>
                  'Solo esta permitido hasta 18 caracteres',
              ValidationMessage.minLength: (error) =>
                  'Solo esta permitido un minimo de 6 caracteres',
            },
            obscureText: showPassword.value,
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color:
                    showPassword.value ? Colors.grey : const Color(0xff18255c),
              ),
              onPressed: () => showPassword.value = !showPassword.value,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
              style: GoogleFonts.itim(
                fontSize: 20,
              ),
              text: 'Crear cuenta',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (form.invalid) {
                  form.markAllAsTouched();
                  return;
                }
                nombre = form.control('name').value!;
                email = form.control('email').value!;
                password = form.control('password').value!;
                authRepository.registerUser(
                    nombre.trim(), email.trim(), password.trim());
              },
            ),
          ),
        ],
      ),
    );
  }
}
