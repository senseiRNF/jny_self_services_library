import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/health_check_page_controller.dart';

class HealthCheckViewPage extends StatelessWidget {
  final HealthCheckPageController controller;

  const HealthCheckViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Health Check",
        ),
      ),
      body: controller.isHealthCheckRun == false ?
      Center(
        child: ElevatedButton(
          onPressed: () => controller.troubleshooting(),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Run Health Check",
            ),
          ),
        ),
      ) :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              controller.currentTroubleshootState,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "RFID Reader Connection",
                ),
                Icon(
                  controller.isBluetoothConnect
                      ? Icons.check
                      : Icons.close,
                  color: controller.isBluetoothConnect
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Alarm Gate Connection",
                ),
                Icon(
                  controller.isGateServerConnected
                      ? Icons.check
                      : Icons.close,
                  color: controller.isGateServerConnected
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Display Monitor Connection",
                ),
                Icon(
                  controller.isMonitorConnected
                      ? Icons.check
                      : Icons.close,
                  color: controller.isMonitorConnected
                      ? Colors.green
                      : Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () => controller.troubleshooting(),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Re-run Health Check",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}