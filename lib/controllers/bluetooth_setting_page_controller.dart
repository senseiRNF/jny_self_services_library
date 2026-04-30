import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/permission_checker.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/view_pages/bluetooth_setting_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await permissionBluetoothChecker();

      if(permissionToAccessBluetooth) {
        bool isSupported = await FlutterBluePlus.isSupported;

        if(isSupported) {
          adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) async {
            if(state == BluetoothAdapterState.on) {
              String? bluetooth = await LocalSecureStorage.readKey(
                key: StaticVariables.bluetoothKey,
              );

              if(bluetooth != null) {
                LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(
                  jsonDecode(bluetooth),
                );

                if(btJson.bluetoothRemoteId != null) {
                  connectWithDevice(
                    BluetoothDevice(
                      remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!),
                    ),
                  );
                }
              } else {
                startScanningDevices();
              }
            }

            if(mounted) {
              setState(() {
                adapterState = state;
              });
            }
          });
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Failed to start Bluetooth service.\n\nyour Bluetooth device is not a "Bluetooth Low Energy" type',
          );
        }
      } else if(mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Failed to start Bluetooth service',
        );
      }
    });
  }

  Future permissionBluetoothChecker() async {
    PermissionStatus connectPermission = await PermissionChecker.checkBluetoothConnectPermission();

    if(connectPermission.isGranted || connectPermission.isLimited) {
      PermissionStatus scanPermission = await PermissionChecker.checkBluetoohScanPermission();

      if(scanPermission.isGranted || scanPermission.isLimited) {
        if(mounted) {
          setState(() {
            permissionToAccessBluetooth = true;
          });

          MethodChannelNative(
            context: context,
          ).initMethod();
        }
      } else if(mounted) {
        setState(() {
          permissionToAccessBluetooth = false;
        });

        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Unable to access Bluetooth due to permission issue',
        );
      }
    } else if(mounted) {
      setState(() {
        permissionToAccessBluetooth = false;
      });

      LocalDialogFunction.okDialog(
        context: context,
        contentText:  'Unable to access Bluetooth due to permission issue',
      );
    }
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
    try {
      await device.connect(
        license: License.free,
        autoConnect: false,
        timeout: const Duration(seconds: 10),
      );

      if(device.isConnected) {
        await LocalSecureStorage.writeKey(
          key: StaticVariables.bluetoothKey,
          data: jsonEncode(
            LocalBluetoothJson(
              bluetoothRemoteId: device.remoteId.str,
              bluetoothName: device.platformName,
            ).toJson(),
          ),
        );

        if(mounted) {
          setState(() {
            connectedDevice = device;
          });

          MethodChannelNative(
            context: context,
          ).setDeviceToNative(
            device.remoteId.str,
          );
        }

        if(mounted && btConnectionStateSubscription == null) {
          setState(() {
            btConnectionStateSubscription = device.connectionState.listen((state) async {
              if(state == BluetoothConnectionState.disconnected) {
                await device.connect(
                  license: License.free,
                  autoConnect: false,
                  timeout: const Duration(seconds: 10),
                );

                if(mounted && device.isConnected) {
                  setState(() {
                    connectedDevice = device;
                  });

                  try {
                    await MethodChannelNative(context: context)
                        .setDeviceToNative(device.remoteId.str);

                    if(mounted) {
                      LocalRouteNavigator.closeBack(context: context);
                    }
                  } catch(e) {
                    debugPrint("err: $e");
                  }
                }
              }
            });
          });
        }
      }
    } catch(e) {
      if(mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Failed to connect Bluetooth device',
        );
      }
    }
  }

  void disconnectWithDevice() async {
    await btConnectionStateSubscription!.cancel();

    if(mounted) {
      await MethodChannelNative(context: context).removeDeviceFromNative();

      if (connectedDevice != null && connectedDevice!.isConnected) {
        await connectedDevice!.disconnect();

        if (connectedDevice!.isConnected == false) {
          bool deleteResult = await LocalSecureStorage.deleteKey(
            key: StaticVariables.bluetoothKey,
          );

          if(mounted && deleteResult) {
            setState(() {
              connectedDevice = null;
            });
          }
        }
      } else {
        bool deleteResult = await LocalSecureStorage.deleteKey(
          key: StaticVariables.bluetoothKey,
        );

        if(mounted && deleteResult) {
          setState(() {
            connectedDevice = null;
          });
        }
      }
    }
  }

  // void openLockedSetting() async {}

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