import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/presentation/molecules/bottom_navigation_bar_molecule.dart';
import 'package:qr_code_gestor/presentation/utils/my_painter.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';
import 'package:qr_code_gestor/presentation/view/admin_view.dart';
import 'package:qr_code_gestor/presentation/view/qr_gestor.dart';
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';
import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});

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
              SizedBox(
                  height: 60,
                  // color: QRUtils.greyBackground,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('ScannChurch App',
                            style: GoogleFonts.itim(
                                color: QRUtils.white, fontSize: 25)),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x99000000),
                                  blurRadius: 46,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              color: QRUtils.greyBackground),
                          child: IconButton(
                            tooltip: 'Cerrar Sesión',
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(Icons.exit_to_app,
                                color: QRUtils.yellowBackground),
                            onPressed: () {
                              authRepository.logoutUser();
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ),
                      ])),
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
