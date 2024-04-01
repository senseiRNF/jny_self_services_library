import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/networks/network_options.dart';

class ControlGateServices {
  BuildContext context;

  ControlGateServices({
    required this.context,
  });

  Future<bool> postAlarmToGate(List<String> epc) async {
    bool result = false;

    await SharedPrefsFunctions.readData("gate_url").then((gateURL) async {
      if(gateURL != null) {
        await NetworkOption.initNoAPI().then((dio) async {
          LoadingDialog(context: context).show();

          await dio.post(
            "$gateURL/alarms",
            data: {
              "epc": epc,
            },
          ).then((postResult) {
            CloseBack(context: context).go();

            if(postResult.statusCode == 200 || postResult.statusCode == 201) {
              result = true;
            }
          }).catchError((dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          });
        });
      }
    });

    return result;
  }

  Future<bool> deleteAlarmFromGate(List<String> epc) async {
    bool result = false;

    await SharedPrefsFunctions.readData("gate_url").then((gateURL) async {
      if(gateURL != null) {
        await NetworkOption.initNoAPI().then((dio) async {
          LoadingDialog(context: context).show();

          await dio.delete(
            "$gateURL/alarms",
            data: {
              "epc": epc,
            },
          ).then((deleteResult) {
            CloseBack(context: context).go();

            if(deleteResult.statusCode == 200 || deleteResult.statusCode == 201) {
              result = true;
            }
          }).catchError((dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          });
        });
      }
    });

    return result;
  }

  Future<List> getGateLogs() async {
    List result = [];

    await SharedPrefsFunctions.readData("gate_url").then((gateURL) async {
      if(gateURL != null) {
        await NetworkOption.initNoAPI().then((dio) async {
          LoadingDialog(context: context).show();

          await dio.get(
            "$gateURL/logs",
          ).then((getResult) {
            CloseBack(context: context).go();

            if(getResult.statusCode == 200 || getResult.statusCode == 201) {
              if(getResult.data != null) {
                result = getResult.data;
              }
            }
          }).catchError((dioExc) {
            CloseBack(context: context).go();

            if(dioExc.response != null && dioExc.response!.statusCode != 404) {
              ErrorHandler(context: context, dioExc: dioExc).show();
            }
          });
        });
      }
    });

    return result;
  }
}