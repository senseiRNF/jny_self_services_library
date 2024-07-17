import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_history_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/view_pages/check_book_status_setting_view_page.dart';

class CheckBookStatusSettingPage extends StatefulWidget {
  const CheckBookStatusSettingPage({super.key});

  @override
  State<CheckBookStatusSettingPage> createState() => CheckBookStatusSettingPageController();
}

class CheckBookStatusSettingPageController extends State<CheckBookStatusSettingPage> {
  BluetoothDevice? connectedDevice;

  BookDataJson? bookDataJson;
  List<LoanHistories> loanHistoryList = [];

  String? scannedRFID;

  bool isLoadingData = false;

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
        setState(() {
          scannedRFID = rfid.substring(0, 16);
          isLoadingData = true;
        });

        await BookServices(context: context).showBookByRFID(rfid.substring(0, 16)).then((bookResult) async {
          if(bookResult != null) {
            setState(() {
              bookDataJson = bookResult;
            });

            await BookServices(context: context).showBookHistory(rfid.substring(0, 16)).then((historyResult) {
              if(historyResult != null && historyResult.loanHistories != null) {
                setState(() {
                  loanHistoryList = historyResult.loanHistories!;
                  isLoadingData = false;
                });
              }
            }).catchError((err) {
              setState(() {
                isLoadingData = false;
              });
            });
          } else {
            setState(() {
              bookDataJson = null;
            });
          }
        }).catchError((err) {
          setState(() {
            isLoadingData = false;
          });
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
    return CheckBookStatusSettingViewPage(controller: this);
  }
}