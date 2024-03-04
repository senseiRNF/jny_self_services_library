import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/home_page_controller.dart';
import 'package:jny_self_services_library/controllers/sign_in_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/view_pages/splash_view_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageController();
}

class SplashPageController extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    checkAuthorization();
  }

  checkAuthorization() async {
    await SharedPrefsFunctions.readData('account').then((account) {
      if(account != null) {
        Future.delayed(const Duration(seconds: 3), () async {
          ReplaceTo(context: context, target: const HomePage()).go();
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () async {
          ReplaceTo(context: context, target: const SignInPage()).go();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashViewPage();
  }
}