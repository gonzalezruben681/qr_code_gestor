import 'package:flutter/material.dart';
import 'package:qr_code_gestor/presentation/view/home_view.dart';
import 'package:qr_code_gestor/presentation/view/qr_gestor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:qr_code_gestor/presentation/view/qr_scan.dart';
import 'package:qr_code_gestor/presentation/view/register_user_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        '/register': (context) => const RegisterView(),
        '/qrgestor': (context) => const QRGestor(),
        '/qrscan': (context) => const QRScanWiew(),
      },
      // home: QRGestor(),
    );
  }
}
