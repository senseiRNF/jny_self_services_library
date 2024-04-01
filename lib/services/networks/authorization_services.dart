import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_account_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/login_json.dart';
import 'package:jny_self_services_library/services/networks/network_options.dart';

class AuthorizationServices {
  BuildContext context;

  AuthorizationServices({required this.context});

  Future<bool> usingPassword(String username, String password) async {
    bool result = false;

    await NetworkOption.initJNYAPI().then((dio) async {
      LoadingDialog(context: context).show();

      await dio.post(
        '/login',
        data: {
          'login': username,
          'password': password,
        },
      ).then((postResult) async {
        CloseBack(context: context).go();

        LoginJson loginJson = LoginJson.fromJson(postResult.data);

        if(loginJson.loginData != null && loginJson.loginData!.id != null) {
          await SharedPrefsFunctions.writeData(
            'account',
            jsonEncode(
              LocalAccountJson(
                userId: loginJson.loginData!.id!.toString(),
                username: loginJson.loginData!.username,
                name: loginJson.loginData!.name,
                email: loginJson.loginData!.email,
                accessToken: loginJson.loginData!.accessToken,
              ).toJson(),
            ),
          ).then((_) {
            result = true;
          });
        }
      }).catchError((dioExc) {
        CloseBack(context: context).go();

        ErrorHandler(context: context, dioExc: dioExc).show();
      });
    });

    return result;
  }
}