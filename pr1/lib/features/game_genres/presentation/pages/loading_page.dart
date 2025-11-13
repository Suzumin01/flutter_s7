import 'package:flutter/material.dart';
import '../../../../routes.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://img.icons8.com/?size=100&id=119900&format=png&color=000000',
              width: 100,
              height: 100,
              errorBuilder: (_, __, ___) => const Icon(Icons.gamepad, size: 100, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'info.games',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oblivion',
              ),
            ),
          ],
        ),
      ),
    );
  }
}