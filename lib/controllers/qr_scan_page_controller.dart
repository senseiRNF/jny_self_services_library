import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/qr_scan_view_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => QRScanPageController();
}

class QRScanPageController extends State<QRScanPage> {
  MobileScannerController scannerController = MobileScannerController(
    facing: CameraFacing.front,
    detectionSpeed: DetectionSpeed.noDuplicates,
    cameraResolution: const Size(1920, 1080),
  );

  bool isCaptured = false;

  @override
  void initState() {
    super.initState();

    checkCameraPermission();

    DisplayMonitorServices.sendStateToMonitor(
      "SCAN_QR",
      {
        "library_member": {},
        "book_list": {},
      },
    );
  }

  checkCameraPermission() async {
    await Permission.camera.status.then((permissionStatus) async {
      if(permissionStatus.isGranted || permissionStatus.isLimited) {
        return;
      } else {
        await Permission.camera.request().then((requestStatus) async {
          if(requestStatus.isGranted || requestStatus.isLimited) {
            return;
          } else {
            OkDialog(
              context: context,
              content: 'Action canceled, Unable to access camera',
              headIcon: false,
              okPressed: () => CloseBack(context: context).go(),
            ).show();
          }
        });
      }
    });
  }

  updateScannedId(BarcodeCapture result) {
    if(isCaptured == false) {
      setState(() {
        isCaptured = true;
      });

      final List<Barcode> barcodes = result.barcodes;

      if(barcodes[0].rawValue != null) {
        CloseBack(context: context, callbackData: barcodes[0].rawValue!).go();
      } else {
        setState(() {
          isCaptured = false;
        });
      }
    }
  }

  changeCameraFacing() {
    setState(() {
      scannerController.switchCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return QRScanViewPage(controller: this);
  }
}