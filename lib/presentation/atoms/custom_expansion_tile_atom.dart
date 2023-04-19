import 'package:flutter/material.dart';

class CustomExpansionTileAtom extends StatefulWidget {
  const CustomExpansionTileAtom({super.key});

  @override
  State<CustomExpansionTileAtom> createState() =>
      _CustomExpansionTileAtomState();
}

class _CustomExpansionTileAtomState extends State<CustomExpansionTileAtom> {
  String tapToExpandIt = 'Tap to Expand it';
  String sentence = 'Widgets that have global keys reparent their subtrees when'
      ' they are moved from one location in the tree to another location in the'
      ' tree. In order to reparent its subtree, a widget must arrive at its new'
      ' location in the tree in the same animation frame in which it was removed'
      ' from its old location the tree.'
      ' Widgets that have global keys reparent their subtrees when they are moved'
      ' from one location in the tree to another location in the tree. In order'
      ' to reparent its subtree, a widget must arrive at its new location in the'
      ' tree in the same animation frame in which it was removed from its old'
      ' location the tree.';
  bool isExpanded = true;
  bool isExpanded2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                horizontal: isExpanded ? 25 : 0,
                vertical: 20,
              ),
              padding: const EdgeInsets.all(20),
              height: isExpanded ? 70 : 330,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1200),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff6F12E8).withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(5, 10),
                  ),
                ],
                color: const Color(0xff6F12E8),
                borderRadius: BorderRadius.all(
                  Radius.circular(isExpanded ? 20 : 0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tapToExpandIt,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 27,
                      ),
                    ],
                  ),
                  isExpanded ? const SizedBox() : const SizedBox(height: 20),
                  AnimatedCrossFade(
                    firstChild: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                    secondChild: Text(
                      sentence,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.7,
                      ),
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                isExpanded2 = !isExpanded2;
              });
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                horizontal: isExpanded2 ? 25 : 0,
                vertical: 20,
              ),
              padding: const EdgeInsets.all(20),
              height: isExpanded2 ? 70 : 330,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 1200),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffFF5050).withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(5, 10),
                  ),
                ],
                color: const Color(0xffFF5050),
                borderRadius: BorderRadius.all(
                  Radius.circular(isExpanded2 ? 20 : 0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tapToExpandIt,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        isExpanded2
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 27,
                      ),
                    ],
                  ),
                  isExpanded2 ? const SizedBox() : const SizedBox(height: 20),
                  AnimatedCrossFade(
                    firstChild: const Text(
                      '',
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                    secondChild: Text(
                      sentence,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.7,
                      ),
                    ),
                    crossFadeState: isExpanded2
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1200),
                    reverseDuration: Duration.zero,
                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
