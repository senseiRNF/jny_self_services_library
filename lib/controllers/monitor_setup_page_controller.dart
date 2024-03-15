import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:jny_self_services_library/view_pages/monitor_setup_view_page.dart';
import 'package:pocketbase/pocketbase.dart';

class MonitorSetupPage extends StatefulWidget {
  const MonitorSetupPage({super.key});

  @override
  State<MonitorSetupPage> createState() => MonitorSetupPageController();
}

class MonitorSetupPageController extends State<MonitorSetupPage> {
  TextEditingController pairingIDTEC = TextEditingController();

  PocketBase pbConfig = PocketBaseConfig.pb;

  List testingList = [
    "IDLE",
    "BORROW",
    "RENEW",
    "RETURN",
    "SCAN_QR",
    "READ_RFID",
  ];

  @override
  void initState() {
    super.initState();

    checkPairingID();
  }

  Future checkPairingID() async {
    await SharedPrefsFunctions.readData('pairingID').then((pairingIDResult) {
      if(pairingIDResult != null && pairingIDResult != '') {
        setState(() {
          pairingIDTEC.text = pairingIDResult;
        });
      }
    });
  }

  savePairingID() async {
    await SharedPrefsFunctions.writeData('pairingID', pairingIDTEC.text).then((writeResult) {
      if(writeResult == true) {
        OkDialog(
          context: context,
          content: "Success saving Pairing ID",
          headIcon: true,
          okPressed: () => CloseBack(context: context).go(),
        ).show();
      } else {
        OkDialog(
          context: context,
          content: "Failed to save Pairing ID",
          headIcon: false,
        ).show();
      }
    });
  }

  updateState(String state) async {
    await pbConfig.collection('testing').update(
      pairingIDTEC.text,
      body: {
        "state": state,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MonitorSetupViewPage(controller: this);
  }
}