import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_account_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/login_json.dart';
import 'package:local_function_collections/local_function_collections.dart';

class AuthorizationServices {
  static Future<bool> usingPassword({
    required BuildContext context,
    String? username,
    String? password,
  }) async {
    bool result = false;

    CancelToken cancelToken = CancelToken();

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.post,
      apisURL: StaticVariables.mainURL("login"),
      headerRequest: {
        "Accept": "application/json",
      },
      bodyData: {
        'login': username,
        'password': password,
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        LoginJson loginJson = LoginJson.fromJson(
          response?.data ?? {},
        );

        if(loginJson.loginData?.id != null) {
          result = await LocalSecureStorage.writeKey(
            key: StaticVariables.accountKey,
            data: jsonEncode(
              LocalAccountJson(
                userId: loginJson.loginData!.id!.toString(),
                username: loginJson.loginData!.username,
                name: loginJson.loginData!.name,
                email: loginJson.loginData!.email,
                accessToken: loginJson.loginData!.accessToken,
              ).toJson(),
            ),
          );
        }
      }
    } else {
      String errMessage = response?.data?['message']
          ?? "Couldn't retrieve data from server, please try again!";

      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: errMessage,
        );
      }
    }

    return result;
  }
}