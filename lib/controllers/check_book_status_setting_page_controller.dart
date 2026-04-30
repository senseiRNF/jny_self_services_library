import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_history_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/view_pages/check_book_status_setting_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkConnection();

      if(mounted && connectedDevice == null) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: "Bluetooth not connected!",
          onClose: () => LocalRouteNavigator.closeBack(
            context: context,
          ),
        );
      }
    });
  }

  Future checkConnection() async {
    String? bluetooh = await LocalSecureStorage.readKey(
      key: StaticVariables.bluetoothKey,
    );

    if(bluetooh != null) {
      LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(
        jsonDecode(bluetooh),
      );

      if(btJson.bluetoothRemoteId != null) {
        connectedDevice = BluetoothDevice(
          remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!),
        );
      }
    }
  }

  void checkRFIDTagAlarm() async {
    MethodChannelNative(context: context).readRFID().then((rfid) async {
      if(mounted && rfid != null) {
        setState(() {
          scannedRFID = rfid.substring(0, 16);
          isLoadingData = true;
        });

        try {
          BookDataJson? bookResult = await BookServices.showBookByRFID(
            context: context,
            rfid: rfid.substring(0, 16),
          );

          if(mounted && bookResult != null) {
            setState(() {
              bookDataJson = bookResult;
            });

            try {
              BookHistoryDataJson? historyResult = await BookServices.showBookHistory(
                context: context,
                rfid: rfid.substring(0, 16),
              );

              if(mounted && historyResult != null && historyResult.loanHistories != null) {
                setState(() {
                  loanHistoryList = historyResult.loanHistories!;
                  isLoadingData = false;
                });
              }
            } catch(e) {
              if(mounted) {
                setState(() {
                  isLoadingData = false;
                });
              }
            }
          } else {
            setState(() {
              bookDataJson = null;
            });
          }
        } catch(e) {
          if(mounted) {
            setState(() {
              isLoadingData = false;
            });
          }
        }
      } else if(mounted) {
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