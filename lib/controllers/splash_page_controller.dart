import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/home_page_controller.dart';
import 'package:jny_self_services_library/controllers/sign_in_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/view_pages/splash_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageController();
}

class SplashPageController extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => checkAuthorization());
  }

  void checkAuthorization() async {
    Widget target = const SignInPage();

    String? powerLevel = await LocalSecureStorage.readKey(
      key: StaticVariables.powerLevelKey,
    );

    String? account = await LocalSecureStorage.readKey(
      key: StaticVariables.accountKey,
    );

    if(powerLevel == null) {
      await LocalSecureStorage.writeKey(
        key: StaticVariables.powerLevelKey,
        data: '15',
      );
    }

    if(account != null) {
      target = const HomePage();
    }

    Future.delayed(Duration(seconds: 2), () {
      if(mounted) {
        LocalRouteNavigator.replaceWith(
          context: context,
          target: target,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashViewPage();
  }
}