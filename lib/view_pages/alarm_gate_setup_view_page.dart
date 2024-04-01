import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_setup_page_controller.dart';

class AlarmGateSetupViewPage extends StatelessWidget {
  final AlarmGateSetupPageController controller;

  const AlarmGateSetupViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alarm Gate Setup"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: TextField(
              controller: controller.gateURLTEC,
              decoration: const InputDecoration(
                labelText: "Server Gate URL",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.saveGateURL(),
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => controller.saveGateURL(),
              style: ElevatedButton.styleFrom(
                elevation: 10.0,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  'Confirm Server Gate URL',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}