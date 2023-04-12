import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          color: color,
          elevation: 10,
          child: Column(
            children: [
              Container(
                height: 3,
                decoration: const BoxDecoration(
                  color: QRUtils.yellowBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
              ),
              child,
              Container(
                height: 3,
                decoration: const BoxDecoration(
                  color: QRUtils.yellowBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
