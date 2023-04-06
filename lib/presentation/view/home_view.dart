import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Registro')),
          ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
        ],
      )),
    );
  }
}
