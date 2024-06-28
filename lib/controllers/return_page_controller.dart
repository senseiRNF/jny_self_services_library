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
import 'package:jny_self_services_library/services/networks/control_gate_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/return_view_page.dart';

class ReturnPage extends StatefulWidget {
  final LibraryMemberData libraryMemberData;

  const ReturnPage({
    super.key,
    required this.libraryMemberData,
  });

  @override
  State<ReturnPage> createState() => ReturnPageController();
}

class ReturnPageController extends State<ReturnPage> {
  int countScannedRFID = 0;

  bool isOnListen = false;
  bool isAbleToProceed = false;
  bool canPopPage = true;

  StreamSubscription? eventChannelStreamSubscription;

  List scannedRFID = [];
  List<BorrowedDetailDataJson> listBorrowedDetail = [];
  List<Map<bool, BorrowedBooksDataJson>> listBorrowedBooks = [];

  BorrowedDetailDataJson? selectedBorrowedDetail;

  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();

    checkBorrowedBook();
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

  Future checkBorrowedBook() async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    await BookServices(context: context).checkCurrentBorrow(studentId, employeeId, "on loan").then((result) {
      List<BorrowedDetailDataJson> tempList = [];
      List<Map> tempConvertedList = [];

      if(result != null && result.borrowedDetailDataJson != null) {
        for(int i = 0; i < result.borrowedDetailDataJson!.length; i++) {
          tempList.add(result.borrowedDetailDataJson![i]);
          tempConvertedList.add(result.borrowedDetailDataJson![i].toJson());
        }
      }

      setState(() {
        listBorrowedDetail = tempList;
      });

      DisplayMonitorServices.sendStateToMonitor(
        "SHOW_RETURN",
        {
          "library_member": widget.libraryMemberData.toJson(),
          "book_list": tempConvertedList,
        },
      );
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

          if(listBorrowedBooks.isNotEmpty) {
            List<Map> tempConvertedList = [];

            for(int i = 0; i < listBorrowedBooks.length; i++) {
              BorrowedBooksDataJson tempData = listBorrowedBooks[i].values.first;

              if(data.toString().substring(0, 16) == "${listBorrowedBooks[i].values.first.rfidTag!.substring(0, 14)}00") {
                tempConvertedList.add({
                  "scanned": true,
                  "book_data": tempData.toJson(),
                });

                setState(() {
                  listBorrowedBooks[i] = {true: tempData};
                  isAbleToProceed = true;
                });
              } else {
                tempConvertedList.add({
                  "scanned": listBorrowedBooks[i].keys.first,
                  "book_data": tempData.toJson(),
                });
              }
            }

            if(tempConvertedList.isNotEmpty) {
              DisplayMonitorServices.sendStateToMonitor(
                "SHOW_RETURN_LIST",
                {
                  "library_member": widget.libraryMemberData.toJson(),
                  "book_list": tempConvertedList,
                },
              );
            }
          }
        }
      });
    });
  }

  Future cancelRFIDAuto() async {
    if(eventChannelStreamSubscription != null && isOnListen == true) {
      setState(() {
        isOnListen = false;
        eventChannelStreamSubscription!.cancel();
      });
    }
  }

  returnBook(int borrowId) async {
    LoadingDialog(context: context).show();

    if(isOnListen) {
      cancelRFIDAuto();
    }

    List<Map<bool, BorrowedBooksDataJson>> confirmBorrowedBookDataList = [];

    String? studentId;
    String? employeeId;
    String returnDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    String itemList = "";

    bool canProceed = false;

    for(int i = 0; i < listBorrowedBooks.length; i++) {
      if(listBorrowedBooks[i].values.first.id != null && listBorrowedBooks[i].keys.first == true) {
        itemList = itemList.isNotEmpty ? "$itemList,${listBorrowedBooks[i].values.first.id!.toString()}" : listBorrowedBooks[i].values.first.id!.toString();

        confirmBorrowedBookDataList.add({
          false: listBorrowedBooks[i].values.first,
        });

        canProceed = true;
      }
    }

    if(canProceed == true) {
      StreamSubscription tempEventChannelStreamSubscription = const EventChannel('intidata.android/library_app_event').receiveBroadcastStream().listen((data) async {
        if(confirmBorrowedBookDataList.isNotEmpty) {
          for(int i = 0; i < confirmBorrowedBookDataList.length; i++) {
            if(confirmBorrowedBookDataList[i].values.first.rfidTag != null && data.toString().substring(0, 16) == "${confirmBorrowedBookDataList[i].values.first.rfidTag!.substring(0, 14)}00") {
              confirmBorrowedBookDataList[i] = {
                true: confirmBorrowedBookDataList[i].values.first
              };
            }
          }
        }
      });

      Future.delayed(const Duration(seconds: 3), () async {
        CloseBack(context: context).go();

        tempEventChannelStreamSubscription.cancel();

        bool isAccepted = true;

        for(int i = 0; i < confirmBorrowedBookDataList.length; i++) {
          if(confirmBorrowedBookDataList[i].keys.first == false) {
            isAccepted = false;

            break;
          }
        }

        if(isAccepted == true) {
          List<String> epcList = [];

          for(int i = 0; i < listBorrowedBooks.length; i++) {
            if(listBorrowedBooks[i].values.first.id != null && listBorrowedBooks[i].keys.first == true && listBorrowedBooks[i].values.first.rfidTag != null) {
              epcList.add(listBorrowedBooks[i].values.first.rfidTag!);
            }
          }

          await ControlGateServices(context: context).deleteAlarmFromGate(epcList).then((deleteAlarmResult) async {
            if(deleteAlarmResult == true) {
              await BookServices(context: context).returnBook(borrowId, returnDate, itemList, studentId, employeeId).then((result) async {
                if(result == true) {
                  MoveTo(
                    context: context,
                    target: const ThanksPage(
                      type: 1,
                    ),
                    callback: (_) => CloseBack(context: context).go(),
                  ).go();
                } else {
                  await ControlGateServices(context: context).postAlarmToGate(epcList).then((_) async  {
                    closeBorrowedBooks();
                  });
                }
              });
            } else {
              OkDialog(
                context: context,
                content: 'Failed to communicating with gate system, please try again!',
                headIcon: false,
                okPressed: () async => await ControlGateServices(context: context).postAlarmToGate(epcList).then((_) async  {
                  closeBorrowedBooks();
                }),
              ).show();
            }
          });
        } else {
          OkDialog(
            context: context,
            content: 'Failed to Return!\n\nPlease do not remove books from Scanner before process is completed',
            headIcon: false,
            okPressed: () => closeBorrowedBooks(),
          ).show();
        }
      });
    } else {
      CloseBack(context: context).go();

      OkDialog(
        context: context,
        content: 'Failed to Return!\n\nPlease put the books in the Scanner',
        headIcon: false,
        okPressed: () => closeBorrowedBooks(),
      ).show();
    }
  }

  showBorrowedBooks(BorrowedDetailDataJson borrowedDetail) {
    List<Map<bool, BorrowedBooksDataJson>> tempList = [];
    List<Map> tempConvertedList = [];

    if(borrowedDetail.books != null) {
      for(int i = 0; i < borrowedDetail.books!.length; i++) {
        tempList.add({false: borrowedDetail.books![i]});
        tempConvertedList.add({
          "scanned": false,
          "book_data": borrowedDetail.books![i].toJson(),
        });
      }
    }

    setState(() {
      listBorrowedBooks = tempList;
      selectedBorrowedDetail = borrowedDetail;
      canPopPage = false;
    });

    checkConnection().then((_) {
      if(connectedDevice != null) {
        if(isOnListen == false) {
          DisplayMonitorServices.sendStateToMonitor(
            "SHOW_RETURN_LIST",
            {
              "library_member": widget.libraryMemberData.toJson(),
              "book_list": tempConvertedList,
            },
          );

          startRFIDAuto();

          popInstruction();
        }
      } else {
        OkDialog(
          context: context,
          content: 'Bluetooth not connected!',
          headIcon: false,
          okPressed: () => closeBorrowedBooks(),
        ).show();
      }
    });
  }

  closeBorrowedBooks() {
    setState(() {
      listBorrowedBooks.clear();
      scannedRFID.clear();
      isAbleToProceed = false;
      selectedBorrowedDetail = null;

      if(isOnListen == true) {
        isOnListen = false;

        eventChannelStreamSubscription!.cancel();
      }
    });

    checkBorrowedBook();
  }

  clearScannedRFIDList() {
    setState(() {
      listBorrowedBooks.clear();
      scannedRFID.clear();
      isAbleToProceed = false;
    });

    List<Map<bool, BorrowedBooksDataJson>> tempList = [];
    List<Map> tempConvertedList = [];

    if(selectedBorrowedDetail != null && selectedBorrowedDetail!.books != null) {
      for(int i = 0; i < selectedBorrowedDetail!.books!.length; i++) {
        tempList.add({false: selectedBorrowedDetail!.books![i]});
        tempConvertedList.add({
          "scanned": false,
          "book_data": selectedBorrowedDetail!.books![i].toJson(),
        });
      }
    }

    setState(() {
      listBorrowedBooks = tempList;
    });

    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_RETURN_LIST",
      {
        "library_member": widget.libraryMemberData.toJson(),
        "book_list": tempConvertedList,
      },
    );
  }

  Future popInvoked(BuildContext context) async {
    if(listBorrowedBooks.isNotEmpty) {
      closeBorrowedBooks();

      setState(() {
        canPopPage = true;
      });
    }
  }

  popInstruction() {
    showDialog(
      context: context,
      builder: (dialogBuilder) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Place the book in the scanner area to continue',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Image.asset(
                  'assets/images/gifs/books.gif',
                  fit: BoxFit.contain,
                ),
              ),
              ElevatedButton(
                onPressed: () => CloseBack(context: context).go(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "OK",
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReturnViewPage(controller: this);
  }

  @override
  void dispose() {
    if(isOnListen) {
      eventChannelStreamSubscription!.cancel();
    }

    super.dispose();
  }
}