import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_gestor/domain/usecases/auth_usecase.dart';
import 'package:qr_code_gestor/presentation/utils/qr_utils.dart';

class AppBarOrganism extends StatelessWidget {
  const AppBarOrganism({
    super.key,
    required this.authRepository,
  });

  final AuthenticationUseCase authRepository;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        // color: QRUtils.greyBackground,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text('ScannChurch App',
              style: GoogleFonts.itim(color: QRUtils.white, fontSize: 25)),
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
        ]));
  }
}
