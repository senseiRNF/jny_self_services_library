import 'package:permission_handler/permission_handler.dart';

class PermissionChecker {
  static Future<PermissionStatus> checkBluetoothConnectPermission() async {
    PermissionStatus result = PermissionStatus.denied;

    await Permission.bluetoothConnect.status.then((permission) async {
      if(permission.isGranted || permission.isLimited) {
        result = permission;
      } else if(permission.isDenied || permission.isRestricted) {
        await Permission.bluetoothConnect.request().then((newPermission) async {
          result = newPermission;
        });
      }
    });

    return result;
  }

  static Future<PermissionStatus> checkBluetoohScanPermission() async {
    PermissionStatus result = PermissionStatus.denied;

    await Permission.bluetoothScan.status.then((permission) async {
      if(permission.isGranted || permission.isLimited) {
        result = permission;
      } else if(permission.isDenied || permission.isRestricted) {
        await Permission.bluetoothScan.request().then((newPermission) async {
          result = newPermission;
        });
      }
    });

    return result;
  }
}