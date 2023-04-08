// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_input_atom.dart';

import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

// ignore: must_be_immutable
class FormMolecule extends HookConsumerWidget {
  FormMolecule({super.key});

  late String email;
  late String password;

// validaciones del formulario
  final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'password': FormControl<String>(validators: [
      Validators.required,
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
            'Entrar',
            style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: 1),
          ),
          CustomInputAtom(
            icon: Icons.supervised_user_circle,
            placeholder: 'Email',
            formControlName: 'email',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
              ValidationMessage.email: (error) => 'Ingrese un email correcto',
            },
          ),
          CustomInputAtom(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            formControlName: 'password',
            validationMessages: {
              ValidationMessage.required: (error) => 'Este campo es requerido',
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomButtonAtom(
              text: 'Iniciar sesión',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (form.invalid) {
                  form.markAllAsTouched();
                  return;
                }
                email = form.control('email').value!;
                password = form.control('password').value!;
                authRepository.loginUser(email.trim(), password.trim());
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
          ),
        ],
      ),
    );
  }
}
