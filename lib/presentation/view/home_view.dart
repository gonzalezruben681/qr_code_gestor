import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_code_gestor/presentation/view/login_view.dart';
import 'package:qr_code_gestor/presentation/view/main_view.dart';
import 'package:qr_code_gestor/providers/firebase_auth_providers.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(firebaseAuthProvider);
    return FutureBuilder(
      future: authRepository.isUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return const MainView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
