import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:pocketbase/pocketbase.dart';

class DisplayMonitorServices {
  static sendStateToMonitor(String state) async {
    PocketBase pbConfig = PocketBaseConfig.pb;

    await SharedPrefsFunctions.readData('pairingID').then((pairingIDResult) {
      if(pairingIDResult != null && pairingIDResult != '') {
        pbConfig.collection("testing").update(
          pairingIDResult,
          body: {
            "state": state,
          },
        );
      }
    });
  }
}