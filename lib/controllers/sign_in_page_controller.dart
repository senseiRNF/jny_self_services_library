import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/home_page_controller.dart';
import 'package:jny_self_services_library/services/networks/authorization_services.dart';
import 'package:jny_self_services_library/view_pages/sign_in_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageController();
}

class SignInPageController extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePass = true;

  @override
  void initState() {
    super.initState();
  }

  void changeObscure() {
    if(mounted) {
      setState(() {
        obscurePass = !obscurePass;
      });
    }
  }

  void signInSystem() async {
    if(usernameController.text != '' && passwordController.text != '') {
      await AuthorizationServices.usingPassword(
        context: context,
        username: usernameController.text,
        password: passwordController.text,
      ).then((result) {
        if(mounted && result) {
          LocalRouteNavigator.replaceWith(
            context: context,
            target: const HomePage(),
          );
        }
      });
    } else {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Username & Password can't be empty!",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInViewPage(controller: this);
  }
}