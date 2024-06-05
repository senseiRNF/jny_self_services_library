import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_logs_page_controller.dart';

class AlarmGateLogsViewPage extends StatelessWidget {
  final AlarmGateLogsPageController controller;

  const AlarmGateLogsViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alarm Gate Logs",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Start Date",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () => controller.changeDate("start"),
                        child: Text(
                          DateFormat("yyyy-MM-dd").format(controller.startDate),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "End Date",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () => controller.changeDate("end"),
                        child: Text(
                          DateFormat("yyyy-MM-dd").format(controller.endDate),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  children: [
                    const Text(
                      "Sort",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.changeSort(),
                      child: Icon(
                        controller.isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: () => controller.loadAlarmLogs(),
                    icon: const Icon(
                      Icons.search,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: controller.gateLogsDataList.isNotEmpty ?
            RefreshIndicator(
              onRefresh: () async => controller.loadAlarmLogs(),
              child: ListView.builder(
                itemCount: controller.gateLogsDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Gate No: ${controller.gateLogsDataList[index].gateNumber}",
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "EPC: ${controller.gateLogsDataList[index].epc}",
                          ),
                          Text(
                            "Status: ${controller.gateLogsDataList[index].status}",
                          ),
                          Text(
                            "Timestamp: ${controller.gateLogsDataList[index].timestamp}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ) :
            Stack(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'No Logs Found....',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Swipe down to refresh',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                RefreshIndicator(
                  onRefresh: () async => controller.loadAlarmLogs(),
                  child: ListView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}