import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/sign_in_page_controller.dart';

class SignInViewPage extends StatelessWidget {
  final SignInPageController controller;

  const SignInViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
              child: Image.asset(
                'assets/images/jny_logo_hd.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'JNY Self Services Library',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
              child: TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelText: 'Username',
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
              child: TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelText: 'Password',
                  suffixIcon: InkWell(
                    onTap: () => controller.changeObscure(),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        controller.obscurePass ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                obscureText: controller.obscurePass,
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
              child: ElevatedButton(
                onPressed: () => controller.signInSystem(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(5.0),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}