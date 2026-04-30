import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_logs_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/view_pages/alarm_gate_setup_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) => checkGateURL());
  }

  void checkGateURL() async {
    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(mounted && gateURL != null) {
      setState(() {
        gateURLTEC.text = gateURL;
      });
    }
  }

  void saveGateURL() async {
    bool writeResult = await LocalSecureStorage.writeKey(
      key: StaticVariables.gateURLKey,
      data: gateURLTEC.text,
    );

    if(mounted && writeResult) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Success saving Server Gate URL",
        onClose: (_) => LocalRouteNavigator.closeBack(
          context: context,
        ),
      );
    } else if(mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Failed to save Server Gate URL",
      );
    }
  }

  void moveToAlarmLogs() async {
    String? gateURL = await LocalSecureStorage.readKey(
      key: StaticVariables.gateURLKey,
    );

    if(mounted && gateURL != null && gateURL != '') {
      LocalRouteNavigator.moveTo(
        context: context,
        target: const AlarmGateLogsPage(),
      );
    } else if(mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Failed to open logs, please connect to server gate and try again",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlarmGateSetupViewPage(controller: this);
  }
}