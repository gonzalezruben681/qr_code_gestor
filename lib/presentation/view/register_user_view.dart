import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/widgets/custom_button.dart';
import 'package:qr_code_gestor/presentation/widgets/custom_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2f2F2),
      appBar: AppBar(title: const Text('Registro usuario')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 620,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Form(),
              ]),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  bool _showPassword = true;

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
    ]),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 5),
                    blurRadius: 5)
              ]),
          height: 340,
          width: 350,
          padding: const EdgeInsets.all(8.0),
          child: ReactiveForm(
            formGroup: form,
            child: Column(
              children: [
                Text(
                  'Crear Usuario ',
                  style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  icon: Icons.perm_identity,
                  placeholder: 'Nombre',
                  formControlName: 'name',
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Este campo es requerido',
                    ValidationMessage.pattern: (errror) =>
                        'Solo se permiten letras, comas y espacios',
                  },
                ),
                const SizedBox(height: 20),
                CustomInput(
                  icon: Icons.supervised_user_circle,
                  placeholder: 'Email',
                  formControlName: 'email',
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Este campo es requerido',
                    ValidationMessage.email: (error) =>
                        'Ingrese un email correcto',
                  },
                ),
                const SizedBox(height: 20),
                CustomInput(
                  icon: Icons.lock_outline,
                  placeholder: 'Contraseña',
                  formControlName: 'password',
                  validationMessages: {
                    ValidationMessage.required: (error) =>
                        'Este campo es requerido',
                    ValidationMessage.maxLength: (error) =>
                        'Solo esta permitido hasta 18 caracteres',
                  },
                  obscureText: _showPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color:
                          _showPassword ? Colors.grey : const Color(0xff18255c),
                    ),
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Crear cuenta',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (form.invalid) {
                      form.markAllAsTouched();
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
