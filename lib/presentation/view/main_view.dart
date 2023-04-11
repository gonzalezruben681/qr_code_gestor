import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:qr_code_gestor/presentation/molecules/bottom_navigation_bar_molecule.dart';
import 'package:qr_code_gestor/presentation/view/admin_view.dart';
import 'package:qr_code_gestor/presentation/view/qr_gestor.dart';
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';

class MainView extends HookWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    return Scaffold(
        body: IndexedStack(
          index: currentIndex.value,
          children: const [QRScanWiew(), QRGestorView(), AdminView()],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigatorBarMolecule(
          index: currentIndex.value,
          onIndexSelected: (value) {
            currentIndex.value = value;
          },
        ));
  }
}
