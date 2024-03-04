import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/view_pages/check_book_alarm_setting_view_page.dart';

class CheckBookAlarmSettingPage extends StatefulWidget {
  const CheckBookAlarmSettingPage({super.key});

  @override
  State<CheckBookAlarmSettingPage> createState() => CheckBookAlarmSettingPageController();
}

class CheckBookAlarmSettingPageController extends State<CheckBookAlarmSettingPage> {
  BluetoothDevice? connectedDevice;

  BookDataJson? bookDataJson;

  String? scannedRFID;

  @override
  void initState() {
    super.initState();

    checkConnection().then((_) {
      if(connectedDevice == null) {
        OkDialog(
          context: context,
          content: 'Bluetooth not connected!',
          headIcon: false,
          okPressed: () => CloseBack(context: context).go(),
        ).show();
      }
    });
  }

  Future checkConnection() async {
    await SharedPrefsFunctions.readData('bluetooth').then((bt) {
      if(bt != null) {
        LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(jsonDecode(bt));

        if(btJson.bluetoothRemoteId != null) {
          connectedDevice = BluetoothDevice(remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!));
        }
      }
    });
  }

  checkRFIDTagAlarm() async {
    MethodChannelNative(context: context).readRFID().then((rfid) async {
      if(rfid != null) {
        await BookServices(context: context).showBookByRFID(rfid.substring(0, 16)).then((bookResult) {
          if(bookResult != null) {
            setState(() {
              scannedRFID = rfid.substring(0, 16);
              bookDataJson = bookResult;
            });
          } else {
            setState(() {
              scannedRFID = rfid.substring(0, 16);
              bookDataJson = null;
            });
          }
        });
      } else {
        setState(() {
          scannedRFID = null;
          bookDataJson = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckBookAlarmSettingViewPage(controller: this);
  }
}