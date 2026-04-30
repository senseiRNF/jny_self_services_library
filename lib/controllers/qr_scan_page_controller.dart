import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/qr_scan_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCameraPermission();

      DisplayMonitorServices.sendStateToMonitor(
        "SCAN_QR",
        {
          "library_member": {},
          "book_list": {},
        },
      );
    });
  }

  void checkCameraPermission() async {
    await Permission.camera.status.then((permissionStatus) async {
      if(permissionStatus.isGranted || permissionStatus.isLimited) {
        return;
      } else {
        await Permission.camera.request().then((requestStatus) async {
          if(requestStatus.isGranted || requestStatus.isLimited) {
            return;
          } else if(mounted) {
            LocalDialogFunction.okDialog(
              context: context,
              contentText: 'Action canceled, Unable to access camera',
              onClose: () => LocalRouteNavigator.closeBack(
                context: context,
              ),
            );
          }
        });
      }
    });
  }

  void updateScannedId(BarcodeCapture result) {
    if(mounted && isCaptured == false) {
      setState(() {
        isCaptured = true;
      });

      final List<Barcode> barcodes = result.barcodes;

      if(mounted && barcodes[0].rawValue != null) {
        LocalRouteNavigator.closeBack(
          context: context,
          callbackResult: barcodes[0].rawValue!,
        );
      } else if(mounted) {
        setState(() {
          isCaptured = false;
        });
      }
    }
  }

  void changeCameraFacing() {
    if(mounted) {
      setState(() {
        scannerController.switchCamera();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return QRScanViewPage(controller: this);
  }
}