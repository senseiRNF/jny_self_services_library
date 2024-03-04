import 'package:flutter/material.dart';

class SplashViewPage extends StatelessWidget {
  const SplashViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3),
          child: Center(
            child: Image.asset(
              'assets/images/jny_logo_hd.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}