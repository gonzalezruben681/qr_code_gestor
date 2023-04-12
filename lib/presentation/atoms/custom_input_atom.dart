import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomInputAtom extends StatelessWidget {
  final IconData icon;
  final Widget? suffixIcon;
  final String formControlName;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? enabled;
  final TextStyle? style;
  final Map<String, String Function(Object)>? validationMessages;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInputAtom({
    super.key,
    required this.icon,
    required this.placeholder,
    this.keyboardType,
    this.obscureText,
    this.enabled,
    this.suffixIcon,
    this.style,
    required this.formControlName,
    this.validationMessages,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
      child: Stack(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
                color: QRUtils.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 5),
                      blurRadius: 5)
                ]),
          ),
          ReactiveTextField<String>(
            style: style,
            cursorColor: const Color(0xff18255c),
            formControlName: formControlName,
            inputFormatters: inputFormatters,
            autocorrect: false,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType ?? TextInputType.text,
            validationMessages: validationMessages,
            decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.fromLTRB(20.0, 15, 10.0, 10),
                errorStyle: style,
                prefixIcon: Icon(
                  icon,
                  color: const Color(0xff18255c),
                ),
                suffixIcon: suffixIcon,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder),
          ),
        ],
      ),
    );
  }
}
