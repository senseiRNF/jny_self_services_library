import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/development_page_controller.dart';

class DevelopmentViewPage extends StatelessWidget {
  final DevelopmentPageController controller;

  const DevelopmentViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Development Test Page",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          controller.scannedRFID.isEmpty ?
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Place the RFID in the scanner to continue',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ) :
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.scannedRFID.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Text(
                                controller.scannedRFID[index] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.clearScannedRFIDList(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 10.0,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                            child: Text(
                              'Rescan RFID',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.rewriteTest("NF/JC/0"),
                          style: ElevatedButton.styleFrom(
                            elevation: 10.0,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                            child: Text(
                              'Confirm RFID',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}