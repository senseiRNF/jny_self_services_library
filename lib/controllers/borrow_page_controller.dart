import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/thanks_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/borrow_view_page.dart';

class BorrowPage extends StatefulWidget {
  final LibraryMemberData libraryMemberData;

  const BorrowPage({
    super.key,
    required this.libraryMemberData,
  });

  @override
  State<BorrowPage> createState() => BorrowPageController();
}

class BorrowPageController extends State<BorrowPage> {
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

    DisplayMonitorServices.sendStateToMonitor("READ_RFID");
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

          await BookServices(context: context).showBookByRFID(data.toString().substring(0, 16)).then((bookResult) {
            if(bookResult != null) {
              setState(() {
                bookDataList.add(bookResult);
              });
            }
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

  Future borrowBook() async {
    LoadingDialog(context: context).show();

    if(isOnListen) {
      cancelRFIDAuto();
    }

    List<Map<bool, BookDataJson>> confirmBookDataList = [];

    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    String fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String untilDate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 7)));

    String itemList = "";

    for(int i = 0; i < bookDataList.length; i++) {
      if(bookDataList[i].id != null) {
        itemList = itemList.isNotEmpty ? "$itemList,${bookDataList[i].id!.toString()}" : bookDataList[i].id!.toString();
      }

      confirmBookDataList.add({
        false: bookDataList[i]
      });
    }

    StreamSubscription tempEventChannelStreamSubscription = const EventChannel('intidata.android/library_app_event').receiveBroadcastStream().listen((data) async {
      if(confirmBookDataList.isNotEmpty) {
        for(int i = 0; i < confirmBookDataList.length; i++) {
          if(confirmBookDataList[i].values.first.rfidTag != null && data.toString().substring(0, 16) == confirmBookDataList[i].values.first.rfidTag!) {
            confirmBookDataList[i] = {
              true: confirmBookDataList[i].values.first
            };
          }
        }
      }
    });

    Future.delayed(const Duration(seconds: 3), () async {
      CloseBack(context: context).go();

      tempEventChannelStreamSubscription.cancel();

      bool isAccepted = true;

      for(int i = 0; i < confirmBookDataList.length; i++) {
        if(confirmBookDataList[i].keys.first == false) {
          isAccepted = false;

          break;
        }
      }

      if(isAccepted == true) {
        await BookServices(context: context).borrowBook(fromDate, untilDate, itemList, studentId, employeeId).then((result) {
          if(result == true) {
            MoveTo(
              context: context,
              target: const ThanksPage(
                type: 0,
              ),
              callback: (_) => CloseBack(context: context).go(),
            ).go();
          } else {
            startRFIDAuto();
          }
        });
      } else {
        setState(() {
          scannedRFID.clear();
          bookDataList.clear();
        });

        OkDialog(
          context: context,
          content: 'Failed to Borrow!\n\nPlease do not remove books from Scanner before process is completed',
          headIcon: false,
          okPressed: () {
            startRFIDAuto();
          },
        ).show();
      }
    });
  }

  clearScannedRFIDList() {
    setState(() {
      scannedRFID.clear();
      bookDataList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BorrowViewPage(controller: this);
  }

  @override
  void dispose() {
    if(isOnListen) {
      eventChannelStreamSubscription!.cancel();
    }

    super.dispose();
  }
}