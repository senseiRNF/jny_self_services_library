import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hex/hex.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/view_pages/development_view_page.dart';

class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({super.key});

  @override
  State<DevelopmentPage> createState() => DevelopmentPageController();
}

class DevelopmentPageController extends State<DevelopmentPage> {
  int countScannedRFID = 0;

  bool isOnListen = false;

  StreamSubscription? eventChannelStreamSubscription;

  List scannedRFID = [];
  List<BookDataJson> bookDataList = [];

  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();

    checkConnection().then((_) {
      if(connectedDevice != null) {
        if(isOnListen == false) {
          startRFIDAuto();
        }
      } else {
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

  changeOnListenStatus() {
    setState(() {
      isOnListen = !isOnListen;
    });
  }

  startRFIDAuto() async {
    changeOnListenStatus();

    setState(() {
      eventChannelStreamSubscription = const EventChannel('intidata.android/library_app_event').receiveBroadcastStream().listen((data) async {
        if(!scannedRFID.contains(data.toString().substring(0, 16))) {
          setState(() {
            scannedRFID.add(data.toString().substring(0, 16));
          });
        }
      });
    });
  }

  Future cancelRFIDAuto() async {
    if(eventChannelStreamSubscription != null && isOnListen == true) {
      setState(() {
        eventChannelStreamSubscription!.cancel();
      });

      changeOnListenStatus();
    }
  }

  Future<bool> rewriteTest(String code) async {
    bool result = false;

    try {
      List<int> list = utf8.encode(code);

      String hex = HEX.encode(list);

      int codeLength = hex.length;

      print("Code Length: $codeLength");

      int emptyStringLength = 16 - codeLength;

      String emptyString = "";

      for(int i = 0; i < emptyStringLength; i++) {
        emptyString = "${emptyString}0";
      }

      String updatedRFID = (hex + emptyString).toUpperCase();

      print("UPDATED: $updatedRFID");

      result = true;
    } on Error catch(err) {
      print("ERROR: $err");
    }

    // await MethodChannelNative(context: context).writeRFID(
    //   updatedRFID.toUpperCase(),
    // ).then((writeResult) {
    //   if(writeResult == true) {
    //     result = true;
    //   } else {
    //     OkDialog(
    //       context: context,
    //       content: 'Unable to write new RFID tag',
    //       headIcon: false,
    //     ).show();
    //
    //     result = false;
    //   }
    // });

    return result;
  }

  clearScannedRFIDList() {
    setState(() {
      scannedRFID.clear();
      bookDataList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DevelopmentViewPage(controller: this);
  }
}