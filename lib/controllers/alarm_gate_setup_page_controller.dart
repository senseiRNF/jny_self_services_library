import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_logs_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/view_pages/alarm_gate_setup_view_page.dart';

class AlarmGateSetupPage extends StatefulWidget {
  const AlarmGateSetupPage({super.key});

  @override
  State<AlarmGateSetupPage> createState() => AlarmGateSetupPageController();
}

class AlarmGateSetupPageController extends State<AlarmGateSetupPage> {
  TextEditingController gateURLTEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    checkGateURL();
  }

  checkGateURL() async {
    await SharedPrefsFunctions.readData("gate_url").then((gateURL) {
      if(gateURL != null) {
        gateURLTEC.text = gateURL;
      }
    });
  }

  saveGateURL() async {
    await SharedPrefsFunctions.writeData("gate_url", gateURLTEC.text).then((writeURL) {
      if(writeURL == true) {
        OkDialog(
          context: context,
          content: "Success saving Server Gate URL",
          headIcon: true,
          okPressed: () => CloseBack(context: context).go(),
        ).show();
      } else {
        OkDialog(
          context: context,
          content: "Failed to save Server Gate URL",
          headIcon: false,
        ).show();
      }
    });
  }

  moveToAlarmLogs() async {
    await SharedPrefsFunctions.readData("gate_url").then((gateURL) {
      if(gateURL != null && gateURL != '') {
        MoveTo(
          context: context,
          target: const AlarmGateLogsPage(),
        ).go();
      } else {
        OkDialog(
          context: context,
          content: "Failed to open logs, please connect to server gate and try again",
          headIcon: false,
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlarmGateSetupViewPage(controller: this);
  }
}