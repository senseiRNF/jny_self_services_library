import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/networks/jsons/gate_logs_json.dart';
import 'package:local_function_collections/local_function_collections.dart';

class ControlGateServices {
  static Future<bool> postAlarmToGate({
    required BuildContext context,
    required List<String> epc,
  }) async {
    bool result = false;

    CancelToken cancelToken = CancelToken();

    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(!context.mounted) return false;

    if(gateURL == null) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Gate URL has not been set!",
      );

      return false;
    }

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.post,
      apisURL: "$gateURL/alarms",
      headerRequest: {
        "Accept": "application/json",
      },
      bodyData: {
        "epc": epc,
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      result = true;
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

  static Future<bool> deleteAlarmFromGate({
    required BuildContext context,
    required List<String> epc,
  }) async {
    bool result = false;

    CancelToken cancelToken = CancelToken();

    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(!context.mounted) return false;

    if(gateURL == null) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Gate URL has not been set!",
      );

      return false;
    }

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.delete,
      apisURL: "$gateURL/alarms",
      headerRequest: {
        "Accept": "application/json",
      },
      bodyData: {
        "epc": epc,
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      result = true;
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

  static Future<List<GateLogsData>> getGateLogs({
    required BuildContext context,
    String? startDate,
    String? endDate,
    required bool isAscending,
  }) async {
    List<GateLogsData> result = [];

    CancelToken cancelToken = CancelToken();

    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(!context.mounted) return [];

    if(gateURL == null) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Gate URL has not been set!",
      );

      return [];
    }

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: "$gateURL/logs",
      headerRequest: {
        "Accept": "application/json",
      },
      parameters: {
        "start_date": startDate,
        "end_date": endDate,
        "order": isAscending == true
            ? "asc"
            : "desc",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if(response?.statusCode == 200 || response?.statusCode == 201) {
      if(response?.data is Map<String, dynamic>) {
        GateLogsJson gateLogsJson = GateLogsJson.fromJson(
          response?.data ?? {},
        );

        result = gateLogsJson.gateLogsData ?? [];
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

  static Future<bool> checkGateConnections({
    required BuildContext context,
  }) async {
    bool result = false;

    CancelToken cancelToken = CancelToken();

    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(!context.mounted) return false;

    if(gateURL == null) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Gate URL has not been set!",
      );

      return false;
    }

    Response? response = await LocalAPIsRequest.submitRequest(
      requestType: RequestType.get,
      apisURL: "$gateURL/logs",
      headerRequest: {
        "Accept": "application/json",
      },
      parameters: {
        "start_date": DateFormat("yyyy-MM-dd").format(
          DateTime.now(),
        ),
        "end_date": DateFormat("yyyy-MM-dd").format(
          DateTime.now(),
        ),
        "order": "asc",
      },
      cancelToken: cancelToken,
      usingloadingDialog: context,
    );

    if((response?.statusCode ?? 999) < 500) {
      result = true;
    } else if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: response == null
            ? "Couldn't retrieve data from server, please try again!"
            : "Server is having trouble (Error ${response.statusCode})",
      );
    }

    return result;
  }
}