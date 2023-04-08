import 'package:flutter/material.dart';

class CardAtom extends StatelessWidget {
  final Widget child;
  final Color? color;
  const CardAtom({
    super.key,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        child: child,
      ),
    );
  }
}
