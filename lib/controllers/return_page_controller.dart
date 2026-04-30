import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/thanks_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/locals/local_jsons/local_bluetooth_json.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/control_gate_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/return_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

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
    String? encodedBluetooth = await LocalSecureStorage.readKey(
      key: StaticVariables.bluetoothKey,
    );

    LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(
      encodedBluetooth != null
          ? jsonDecode(encodedBluetooth)
          : {},
    );

    if(btJson.bluetoothRemoteId != null) {
      connectedDevice = BluetoothDevice(remoteId: DeviceIdentifier(btJson.bluetoothRemoteId!));
    }
  }

  Future checkBorrowedBook() async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    BorrowedDetailJson? borrowedDetailJson = await BookServices.checkCurrentBorrow(
      context: context,
      studentId: studentId,
      employeeId: employeeId,
      status: "on loan",
    );

    List<BorrowedDetailDataJson> tempList = [];
    List<Map> tempConvertedList = [];

    if(borrowedDetailJson?.borrowedDetailDataJson != null) {
      for(BorrowedDetailDataJson data in borrowedDetailJson?.borrowedDetailDataJson ?? []) {
        tempList.add(data);
        tempConvertedList.add(data.toJson());
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
  }

  void changeOnListenStatus() {
    if(mounted) {
      setState(() {
        isOnListen = !isOnListen;
      });
    }
  }

  void startRFIDAuto() async {
    changeOnListenStatus();

    if(mounted) {
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
  }

  Future cancelRFIDAuto() async {
    if(mounted && eventChannelStreamSubscription != null && isOnListen == true) {
      setState(() {
        isOnListen = false;
        eventChannelStreamSubscription!.cancel();
      });
    }
  }

  void showBorrowedBooks(BorrowedDetailDataJson borrowedDetail) async {
    List<Map<bool, BorrowedBooksDataJson>> tempList = [];
    List<Map> tempConvertedList = [];

    if(borrowedDetail.books != null) {
      for(BorrowedBooksDataJson data in borrowedDetail.books ?? []) {
        tempList.add({false: data});
        tempConvertedList.add({
          "scanned": false,
          "book_data": data.toJson(),
        });
      }
    }

    setState(() {
      listBorrowedBooks = tempList;
      selectedBorrowedDetail = borrowedDetail;
    });

    await checkConnection();

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
    } else if(mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Bluetooth not connected!',
        onClose: () => closeBorrowedBooks(),
      );
    }
  }

  void returnBook(int borrowId) async {
    LocalDialogFunction.loadingDialog(context: context);

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

      Future.delayed(const Duration(seconds: 2), () async {
        if(mounted) {
          LocalRouteNavigator.closeBack(context: context);
        }

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

          if(mounted) {
            bool deleteAlarm = await ControlGateServices.deleteAlarmFromGate(
              context: context, epc: epcList,
            );

            if(mounted && deleteAlarm == true) {
              bool returnBook = await BookServices.returnBook(
                context: context,
                borrowId: borrowId,
                returnDate: returnDate,
                itemList: itemList,
                studentId: studentId,
                employeeId: employeeId,
              );

              if(mounted && returnBook) {
                setState(() {
                  listBorrowedBooks.clear();
                  scannedRFID.clear();
                });

                LocalRouteNavigator.moveTo(
                  context: context,
                  target: const ThanksPage(
                    type: 1,
                  ),
                  callbackFunction: (_) => LocalRouteNavigator.closeBack(
                    context: context,
                  ),
                );
              } else if(mounted) {
                ControlGateServices.postAlarmToGate(
                  context: context,
                  epc: epcList,
                ).then((_) {
                  closeBorrowedBooks();
                });
              }
            } else if(mounted) {
              LocalDialogFunction.okDialog(
                context: context,
                contentText: 'Failed to communicating with gate system, please try again!',
                onClose: () async {
                  ControlGateServices.postAlarmToGate(
                    context: context,
                    epc: epcList,
                  ).then((_) {
                    closeBorrowedBooks();
                  });
                },
              );
            }
          }
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Failed to Return!\n\nPlease do not remove books from Scanner before process is completed',
            onClose: () => closeBorrowedBooks(),
          );
        }
      });
    } else if(mounted) {
      LocalRouteNavigator.closeBack(context: context);

      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to Return!\n\nPlease put the books in the Scanner',
        onClose: () => closeBorrowedBooks(),
      );
    }
  }

  void closeBorrowedBooks() {
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

  void clearScannedRFIDList() {
    if(mounted) {
      setState(() {
        listBorrowedBooks.clear();
        scannedRFID.clear();
        isAbleToProceed = false;
      });
    }

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

    if(mounted) {
      setState(() {
        listBorrowedBooks = tempList;
      });
    }

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
    }
  }

  void popInstruction() {
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
                onPressed: () => LocalRouteNavigator.closeBack(
                  context: context,
                ),
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