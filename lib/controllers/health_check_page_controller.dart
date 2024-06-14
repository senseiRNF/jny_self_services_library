import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/functions/permission_checker.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/control_gate_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/health_check_view_page.dart';
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

  troubleshooting() async {
    await checkBluetoothConnection().then((_) async =>
        await checkGateConnection().then((_) async =>
            await checkMonitorConnection().then((_) =>
                setState(() {
                  currentTroubleshootState = "Completed";
                })
            )
        )
    );

    setState(() {
      isHealthCheckRun = true;
    });
  }

  Future checkBluetoothConnection() async {
    setState(() {
      currentTroubleshootState = "Checking Bluetooth Activity";
    });

    await PermissionChecker.checkBluetoothConnectPermission().then((connectPermission) async {
      if(connectPermission.isGranted || connectPermission.isLimited) {
        await PermissionChecker.checkBluetoohScanPermission().then((scanPermission) async {
          if(scanPermission.isGranted || scanPermission.isLimited) {
            await FlutterBluePlus.isSupported.then((isSupported) {
              if(isSupported) {
                adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) async {
                  if(state == BluetoothAdapterState.on) {
                    await SharedPrefsFunctions.readData('bluetooth').then((bt) {
                      if(bt != null) {
                        LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(jsonDecode(bt));

                        if(btJson.bluetoothRemoteId != null) {
                          setState(() {
                            isBluetoothConnect = BluetoothDevice(remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!)).isConnected;
                          });
                        } else {
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
                  } else {
                    setState(() {
                      isBluetoothConnect = false;
                    });
                  }
                });
              } else {
                setState(() {
                  isBluetoothConnect = false;
                });
              }
            });
          } else {
            setState(() {
              isBluetoothConnect = false;
            });
          }
        });
      } else {
        setState(() {
          isBluetoothConnect = false;
        });
      }
    });
  }

  Future checkGateConnection() async {
    setState(() {
      currentTroubleshootState = "Checking Gate Activity";
    });

    await ControlGateServices(context: context).checkGateConnections().then((connection) => setState(() {
      isGateServerConnected = connection;
    }));
  }

  Future checkMonitorConnection() async {
    setState(() {
      currentTroubleshootState = "Checking Monitor Activity";
    });

    await DisplayMonitorServices.checkMonitorConnections().then((connection) => setState(() {
      isMonitorConnected = connection;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return HealthCheckViewPage(controller: this);
  }
}