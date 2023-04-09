import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/molecules/bottom_navigation_bar_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(child: Text('main view')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              color: QRUtils.yellowBackground,
            ),
            padding: const EdgeInsets.all(12.0),
            child: const Image(image: AssetImage('assets/img/qr_scan.png')),
          ),
        ),
        bottomNavigationBar: const BottomNavigatorBarMolecule());
  }
}
