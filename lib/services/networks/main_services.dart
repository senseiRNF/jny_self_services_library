import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:local_function_collections/local_function_collections.dart';

class MainServices {
  static Future<LibraryMemberJson?> showLibraryMember({
    required BuildContext context,
    String? qr,
  }) async {
    LibraryMemberJson? result;

    CancelToken cancelToken = CancelToken();

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: StaticVariables.mainURL(
        "library/member",
      ),
      headerRequest: {
        "Accept": "application/json",
      },
      parameters: {
        'qr': qr,
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        result = LibraryMemberJson.fromJson(
          response?.data ?? {},
        );
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