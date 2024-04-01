import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/monitor_setup_page_controller.dart';

class MonitorSetupViewPage extends StatelessWidget {
  final MonitorSetupPageController controller;

  const MonitorSetupViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Monitor Setup",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: TextField(
              controller: controller.pairingIDTEC,
              decoration: const InputDecoration(
                labelText: "Monitor Pairing ID",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.savePairingID(),
              textInputAction: TextInputAction.done,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                ),
                itemCount: controller.testingList.length,
                itemBuilder: (listContext, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => controller.updateState(
                        controller.testingList[index].keys.first,
                        controller.testingList[index].values.first,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 10.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        child: Text(
                          controller.testingList[index].keys.first,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => controller.savePairingID(),
              style: ElevatedButton.styleFrom(
                elevation: 10.0,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  'Confirm Pairing ID',
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