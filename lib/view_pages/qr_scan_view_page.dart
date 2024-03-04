import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/qr_scan_page_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanViewPage extends StatelessWidget {
  final QRScanPageController controller;

  const QRScanViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan your card to continue',
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: SizedBox(
                width: 500.0,
                height: 500.0,
                child: MobileScanner(
                  controller: controller.scannerController,
                  onDetect: (result) {
                    controller.updateScannedId(result);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 50.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset(
                'assets/images/gifs/scan_qr_code.gif',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeCameraFacing(),
        child: const Icon(
          Icons.cameraswitch_outlined,
        ),
      ),
    );
  }
}