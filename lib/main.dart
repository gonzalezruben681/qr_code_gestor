import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_gestor/presentation/view/home_view.dart';
import 'package:qr_code_gestor/presentation/view/login_view.dart';
import 'package:qr_code_gestor/presentation/view/main_view.dart';
import 'package:qr_code_gestor/presentation/view/qr_gestor.dart';
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';
import 'package:qr_code_gestor/presentation/view/register_user_view.dart';
import 'package:qr_code_gestor/presentation/view/reset_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),
        '/login': (context) => const LoginView(),
        '/main': (context) => const MainView(),
        '/register': (context) => const RegisterView(),
        '/reset_password': (context) => const ResetView(),
        '/qrgestor': (context) => const QRGestorView(),
        '/qrscan': (context) => const QRScanWiew(),
      },
    );
  }
}
