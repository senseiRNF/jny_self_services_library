import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/permission_checker.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/view_pages/bluetooth_setting_view_page.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothSettingPage extends StatefulWidget {
  const BluetoothSettingPage({super.key});

  @override
  State<BluetoothSettingPage> createState() => BluetoothSettingPageController();
}

class BluetoothSettingPageController extends State<BluetoothSettingPage> {
  bool permissionToAccessBluetooth = false;
  bool isScanning = false;
  bool isLocked = true;

  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;

  StreamSubscription<BluetoothAdapterState>? adapterStateSubscription;
  StreamSubscription<List<ScanResult>>? scanResultSubscription;
  StreamSubscription<BluetoothConnectionState>? btConnectionStateSubscription;

  List<ScanResult> bluetoothDeviceScanResult = [];

  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();

    permissionBluetoothChecker().then((_) async {
      if(permissionToAccessBluetooth) {
        await FlutterBluePlus.isSupported.then((isSupported) {
          if(isSupported) {
            adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) async {
              if(state == BluetoothAdapterState.on) {
                await SharedPrefsFunctions.readData('bluetooth').then((bt) {
                  if(bt != null) {
                    LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(jsonDecode(bt));

                    if(btJson.bluetoothRemoteId != null) {
                      connectWithDevice(BluetoothDevice(remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!)));
                    }
                  } else {
                    startScanningDevices();
                  }
                });
              }

              setState(() {
                adapterState = state;
              });
            });
          } else {
            OkDialog(
              context: context,
              content: 'Failed to start Bluetooth service.\n\nyour Bluetooth device is not a "Bluetooth Low Energy" type',
              headIcon: false,
            ).show();
          }
        });
      } else {
        OkDialog(
          context: context,
          content: 'Failed to start Bluetooth service',
          headIcon: false,
        ).show();
      }
    });
  }

  Future permissionBluetoothChecker() async {
    await PermissionChecker.checkBluetoothConnectPermission().then((connectPermission) async {
      if(connectPermission.isGranted || connectPermission.isLimited) {
        await PermissionChecker.checkBluetoohScanPermission().then((scanPermission) async {
          if(scanPermission.isGranted || scanPermission.isLimited) {
            setState(() {
              permissionToAccessBluetooth = true;
            });

            MethodChannelNative(context: context).initMethod();
          } else {
            setState(() {
              permissionToAccessBluetooth = false;
            });

            OkDialog(
              context: context,
              content: 'Unable to access Bluetooth due to permission issue',
              headIcon: false,
            ).show();
          }
        });
      } else {
        setState(() {
          permissionToAccessBluetooth = false;
        });

        OkDialog(
          context: context,
          content: 'Unable to access Bluetooth due to permission issue',
          headIcon: false,
        ).show();
      }
    });
  }

  Future startScanningDevices() async {
    if(adapterState == BluetoothAdapterState.off) {
      await FlutterBluePlus.turnOn().then((_) async {
        if(scanResultSubscription == null) {
          setState(() {
            scanResultSubscription = FlutterBluePlus.onScanResults.listen((event) {
              setState(() {
                bluetoothDeviceScanResult = event;
              });
            });
          });
        }

        await FlutterBluePlus.startScan().then((_) {
          setState(() {
            isScanning = true;
          });
        });

        Future.delayed(const Duration(seconds: 10), () async {
          await FlutterBluePlus.stopScan().then((_) {
            setState(() {
              isScanning = false;
            });
          });
        });
      });
    } else {
      if(scanResultSubscription == null) {
        setState(() {
          scanResultSubscription = FlutterBluePlus.onScanResults.listen((event) {
            setState(() {
              bluetoothDeviceScanResult = event;
            });
          });
        });
      }

      await FlutterBluePlus.startScan().then((_) {
        setState(() {
          isScanning = true;
        });
      });

      Future.delayed(const Duration(seconds: 10), () async {
        await FlutterBluePlus.stopScan().then((_) {
          setState(() {
            isScanning = false;
          });
        });
      });
    }
  }

  Future connectWithDevice(BluetoothDevice device) async {
    await device.connect(
      autoConnect: false,
      timeout: const Duration(seconds: 10),
    ).then((_) async {
      if(device.isConnected) {
        await SharedPrefsFunctions.writeData(
          'bluetooth',
          jsonEncode(
            LocalBluetoothJson(
              bluetoothRemoteId: device.remoteId.str,
              bluetoothName: device.platformName,
            ).toJson(),
          ),
        ).then((_) {
          setState(() {
            connectedDevice = device;
          });

          MethodChannelNative(context: context).setDeviceToNative(device.remoteId.str);

          if(btConnectionStateSubscription == null) {
            setState(() {
              btConnectionStateSubscription = device.connectionState.listen((state) async {
                if(state == BluetoothConnectionState.disconnected) {
                  await device.connect(
                    autoConnect: false,
                    timeout: const Duration(seconds: 10),
                  ).then((_) {
                    if(device.isConnected) {
                      setState(() {
                        connectedDevice = device;
                      });

                      MethodChannelNative(context: context).setDeviceToNative(device.remoteId.str).then((_) {
                        CloseBack(context: context).go();
                      });
                    }
                  });
                }
              });
            });
          }
        });
      }
    }).catchError((err) {
      OkDialog(
        context: context,
        content: 'Failed to connect Bluetooth device',
        headIcon: false,
      ).show();
    });
  }

  disconnectWithDevice() async {
    setState(() {
      btConnectionStateSubscription!.cancel().then((_) async {
        MethodChannelNative(context: context).removeDeviceFromNative().then((_) async {
          if(connectedDevice != null && connectedDevice!.isConnected) {
            await connectedDevice!.disconnect().then((_) {
              if(connectedDevice!.isConnected == false) {
                SharedPrefsFunctions.removeData('bluetooth');

                setState(() {
                  connectedDevice = null;
                });
              }
            });
          } else {
            SharedPrefsFunctions.removeData('bluetooth');

            setState(() {
              connectedDevice = null;
            });
          }
        });
      });
    });
  }

  openLockedSetting() async {

  }

  @override
  Widget build(BuildContext context) {
    return BluetoothSettingViewPage(controller: this);
  }

  @override
  void dispose() {
    if(adapterStateSubscription != null) {
      adapterStateSubscription!.cancel();
    }

    if(scanResultSubscription != null) {
      scanResultSubscription!.cancel();
    }

    if(btConnectionStateSubscription != null) {
      btConnectionStateSubscription!.cancel();
    }

    super.dispose();
  }
}