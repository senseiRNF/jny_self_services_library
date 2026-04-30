import 'package:flutter/cupertino.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:local_function_collections/local_function_collections.dart';
import 'package:pocketbase/pocketbase.dart';

class DisplayMonitorServices {
  static Future sendStateToMonitor(String state, Map args) async {
    PocketBase pbConfig = PocketBaseConfig.pb;

    String? pairingId = await LocalSecureStorage.readKey(
      key: StaticVariables.pairingIdKey,
    );

    if((pairingId ?? "") != "") {
      pbConfig.collection(
        StaticVariables.pocketBaseKey,
      ).update(
        pairingId!,
        body: {
          "state": state,
          "args": args,
        },
      );
    }
  }

  static Future<bool> checkMonitorConnections() async {
    bool result = false;

    PocketBase pbConfig = PocketBaseConfig.pb;

    try {
      await pbConfig.collection(
        StaticVariables.pocketBaseKey,
      ).getFirstListItem("");

      result = true;
    } catch(e) {
      debugPrint("Err: $e");
    }

    return result;
  }
}