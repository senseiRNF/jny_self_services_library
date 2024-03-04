import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/home_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/authorization_services.dart';
import 'package:jny_self_services_library/view_pages/sign_in_view_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageController();
}

class SignInPageController extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePass = true;

  changeObscure() {
    setState(() {
      obscurePass = !obscurePass;
    });
  }

  signInSystem() async {
    if(usernameController.text != '' && passwordController.text != '') {
      await AuthorizationServices(context: context).usingPassword(usernameController.text, passwordController.text).then((result) {
        if(result == true) {
          ReplaceTo(context: context, target: const HomePage()).go();
        }
      });
    } else {
      OkDialog(context: context, content: "Username & Password can't be empty!", headIcon: false).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SignInViewPage(controller: this);
  }
}