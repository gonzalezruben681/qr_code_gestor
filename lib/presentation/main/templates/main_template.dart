import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/presentation/main/organisms/app_bar_organism.dart';
import 'package:qr_code_gestor/presentation/molecules/bottom_navigation_bar_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/my_painter.dart';

import 'package:qr_code_gestor/presentation/view/admin_view.dart';
import 'package:qr_code_gestor/presentation/view/qr_gestor.dart';
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';
import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

class MainTemplate extends HookConsumerWidget {
  const MainTemplate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final authRepository = ref.read(firebaseAuthProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 109, 108, 108),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: size.height,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * .80,
                      left: size.width * .05,
                      child: CustomPaint(
                        painter: MyPainter(130),
                      ),
                    ),
                    Positioned(
                      top: size.height * .1,
                      left: size.width * .8,
                      child: CustomPaint(
                        painter: MyPainter(170),
                      ),
                    ),
                  ],
                ),
              ),
              IndexedStack(
                index: currentIndex.value,
                children: const [QRScanWiew(), QRGestorView(), AdminView()],
              ),
              AppBarOrganism(authRepository: authRepository),
            ],
          ),
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
