import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/services/networks/network_options.dart';

class MainServices {
  final BuildContext context;

  MainServices({
    required this.context,
  });

  Future<LibraryMemberJson?> showLibraryMember(String? qr) async {
    LibraryMemberJson? result;

    await NetworkOption.init().then((dio) async {
      LoadingDialog(context: context).show();

      await dio.get(
        '/library/member',
        queryParameters: {
          'qr': qr,
        },
      ).then((getResult) {
        result = LibraryMemberJson.fromJson(getResult.data);

        CloseBack(context: context).go();
      }).catchError((dioExc) {
        CloseBack(context: context).go();

        ErrorHandler(context: context, dioExc: dioExc).show();
      });
    });

    return result;
  }
}