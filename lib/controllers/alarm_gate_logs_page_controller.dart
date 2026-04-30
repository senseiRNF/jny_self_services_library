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

  bool isAscending = true;

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

  void loadAlarmLogs() async {
    List<GateLogsData> gateLogResult = await ControlGateServices.getGateLogs(
      context: context,
      startDate: DateFormat("yyyy-MM-dd").format(startDate),
      endDate: DateFormat("yyyy-MM-dd").format(endDate),
      isAscending: isAscending,
    );

    if(mounted) {
      setState(() {
        gateLogsDataList = gateLogResult;
      });
    }
  }

  void changeDate(String type) {
    showDatePicker(
      context: context,
      initialDate: type == "start" ? startDate : endDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2080),
    ).then((newDate) {
      if(newDate != null) {
        if(mounted && type == "start") {
          setState(() {
            startDate = newDate;
          });
        } else if(mounted) {
          setState(() {
            endDate = newDate;
          });
        }
      }
    });
  }

  void changeSort() => mounted ? setState(() {
    isAscending = !isAscending;
  }) : {};

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