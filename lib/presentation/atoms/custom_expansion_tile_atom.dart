import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class CustomExpansionTileAtom extends StatefulWidget {
  const CustomExpansionTileAtom(
      {super.key, this.index, required this.text, this.title, this.subtitle});
  final int? index;
  final String text;
  final Widget? title;
  final Widget? subtitle;

  @override
  State<CustomExpansionTileAtom> createState() =>
      _CustomExpansionTileAtomState();
}

class _CustomExpansionTileAtomState extends State<CustomExpansionTileAtom> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          if (selectedIndex == widget.index) {
            selectedIndex = null;
          } else {
            selectedIndex = widget.index;
          }
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(
          horizontal: selectedIndex == widget.index ? 12 : 0,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: selectedIndex == widget.index ? 108 : 50,
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 1200),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: QRUtils.greyBackground.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(5, 10),
            ),
          ],
          color: QRUtils.greyBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(selectedIndex == widget.index ? 10 : 20),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.itim(
                    color: QRUtils.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(
                  selectedIndex == widget.index
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: QRUtils.white,
                  size: 27,
                ),
              ],
            ),
            // selectedIndex == index
            //     ? const SizedBox()
            //     : const SizedBox(height: 20),
            Expanded(
              child: AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: ListTile(
                  title: widget.title,
                  subtitle: widget.subtitle,
                ),
                crossFadeState: selectedIndex == widget.index
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 1200),
                reverseDuration: Duration.zero,
                sizeCurve: Curves.fastLinearToSlowEaseIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
