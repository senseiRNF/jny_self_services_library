import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/functions/permission_checker.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/control_gate_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/health_check_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthCheckPage extends StatefulWidget {
  const HealthCheckPage({super.key});

  @override
  State<HealthCheckPage> createState() => HealthCheckPageController();
}

class HealthCheckPageController extends State<HealthCheckPage> {
  bool isHealthCheckRun = false;

  bool isBluetoothConnect = false;
  bool isGateServerConnected = false;
  bool isMonitorConnected = false;

  StreamSubscription<BluetoothAdapterState>? adapterStateSubscription;

  String currentTroubleshootState = "No Activity";

  void troubleshooting() async {
    try {
      await checkBluetoothConnection();
      await checkGateConnection();
      await checkMonitorConnection();

      if(mounted) {
        setState(() {
          isHealthCheckRun = true;
          currentTroubleshootState = "Completed";
        });
      }
    } catch(e) {
      debugPrint("err: $e");
    }
  }

  Future checkBluetoothConnection() async {
    if(mounted) {
      setState(() {
        currentTroubleshootState = "Checking Bluetooth Activity";
      });
    }

    PermissionStatus btConnectPermission = await PermissionChecker.checkBluetoothConnectPermission();

    if(btConnectPermission.isGranted || btConnectPermission.isLimited) {
      PermissionStatus btScanPermission = await PermissionChecker.checkBluetoohScanPermission();

      if(btScanPermission.isGranted || btScanPermission.isLimited) {
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

                if(mounted && btJson.bluetoothRemoteId != null) {
                  setState(() {
                    isBluetoothConnect = BluetoothDevice(
                      remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!),
                    ).isConnected;
                  });
                } else if(mounted) {
                  setState(() {
                    isBluetoothConnect = false;
                  });
                }
              } else if(mounted) {
                setState(() {
                  isBluetoothConnect = false;
                });
              }
            } else {
              setState(() {
                isBluetoothConnect = false;
              });
            }
          });
        } else if(mounted) {
          setState(() {
            isBluetoothConnect = false;
          });
        }
      }
    } else if(mounted) {
      setState(() {
        isBluetoothConnect = false;
      });
    }
  }

  Future checkGateConnection() async {
    if(mounted) {
      setState(() {
        currentTroubleshootState = "Checking Gate Activity";
      });
    }

    bool connection = await ControlGateServices.checkGateConnections(
      context: context,
    );

    if(mounted) {
      setState(() {
        isGateServerConnected = connection;
      });
    }
  }

  Future checkMonitorConnection() async {
    if(mounted) {
      setState(() {
        currentTroubleshootState = "Checking Monitor Activity";
      });
    }

    bool connection = await DisplayMonitorServices.checkMonitorConnections();

    if(mounted) {
      setState(() {
        isMonitorConnected = connection;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HealthCheckViewPage(controller: this);
  }
}