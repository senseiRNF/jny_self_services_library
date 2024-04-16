import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/services/networks/control_gate_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/gate_logs_json.dart';
import 'package:jny_self_services_library/view_pages/alarm_gate_logs_view_page.dart';

class AlarmGateLogsPage extends StatefulWidget {
  const AlarmGateLogsPage({super.key});

  @override
  State<AlarmGateLogsPage> createState() => AlarmGateLogsPageController();
}

class AlarmGateLogsPageController extends State<AlarmGateLogsPage> {
  List<GateLogsData> gateLogsDataList = [];

  DateTime startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime endDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  loadAlarmLogs() async {
    await ControlGateServices(context: context).getGateLogs(
      DateFormat("yyyy-MM-dd").format(startDate),
      DateFormat("yyyy-MM-dd").format(endDate),
    ).then((result) {
      setState(() {
        gateLogsDataList = result;
      });
    });
  }

  changeDate(String type) {
    showDatePicker(
      context: context,
      initialDate: type == "start" ? startDate : endDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2080),
    ).then((newDate) {
      if(newDate != null) {
        if(type == "start") {
          setState(() {
            startDate = newDate;
          });
        } else {
          setState(() {
            endDate = newDate;
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadAlarmLogs();
  }

  @override
  Widget build(BuildContext context) {
    return AlarmGateLogsViewPage(controller: this);
  }
}