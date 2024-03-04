import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/splash_page_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SelfServiceLibraryApp());
}

class SelfServiceLibraryApp extends StatelessWidget {
  const SelfServiceLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JNY Library Self Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff632d6a)),
        fontFamily: 'Onest',
      ),
      routes: {
        '/': (BuildContext context) => const SplashPage(),
      },
    );
  }
}