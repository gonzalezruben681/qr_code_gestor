import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class CustomButtonAtom extends StatelessWidget {
  const CustomButtonAtom({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.style,
  });

  final IconData? icon;
  final String? text;
  final TextStyle? style;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      height: 45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: QRUtils.yellowBackground,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon) : const SizedBox.shrink(),
          const SizedBox(width: 8),
          Text(
            text ?? '',
            style: style,
          ),
        ],
      ),
    );
  }
}
