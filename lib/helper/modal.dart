import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/atoms/custom_button_atom.dart';

class PlaceholderDialog extends StatelessWidget {
  const PlaceholderDialog({
    this.icon,
    this.title,
    this.content,
    this.actions = const [],
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final Widget? content;
  final List<Widget> actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: icon,
      title: title == null
          ? null
          : Text(
              title!,
              textAlign: TextAlign.center,
            ),
      content: content,
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
      actions: actions,
    );
  }
}

void mostrarModal(
    {required BuildContext context,
    Widget? icon,
    String? titulo,
    Widget? content,
    Color? backgroundColor,
    required dynamic Function()? onPressed,
    String? text}) {
  showDialog(
    context: context,
    builder: (context) => PlaceholderDialog(
      icon: icon,
      title: titulo,
      content: content,
      backgroundColor: backgroundColor,
      actions: [
        CustomButtonAtom(
            style: GoogleFonts.itim(
              fontSize: 20,
            ),
            onPressed: onPressed,
            text: text ?? 'Aceptar'),
      ],
    ),
  );
}
