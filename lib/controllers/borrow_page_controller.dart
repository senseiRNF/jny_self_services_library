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
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/borrow_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

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

  BookDataJson? lowQuota;

  BluetoothDevice? connectedDevice;

  String fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String untilDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.libraryMemberData.nis != null) {
        await checkUntilDate();

        await checkConnection();

        if(connectedDevice != null) {
          if(isOnListen == false) {
            startRFIDAuto();
          }
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Bluetooth not connected!',
            onClose: () => LocalRouteNavigator.closeBack(
              context: context,
            ),
          );
        }

        DisplayMonitorServices.sendStateToMonitor(
          "READ_RFID",
          {
            "library_member": widget.libraryMemberData.toJson(),
            "book_list": {},
          },
        );
      } else if(widget.libraryMemberData.nik != null) {
        checkConnection().then((_) {
          if(connectedDevice != null) {
            if(isOnListen == false) {
              startRFIDAuto();
            }
          } else if(mounted) {
            LocalDialogFunction.okDialog(
              context: context,
              contentText: 'Bluetooth not connected!',
              onClose: () => LocalRouteNavigator.closeBack(
                context: context,
              ),
            );
          }
        });

        DisplayMonitorServices.sendStateToMonitor(
          "READ_RFID",
          {
            "library_member": widget.libraryMemberData.toJson(),
            "book_list": {},
          },
        );
      }
    });
  }

  Future checkConnection() async {
    String? bt = await LocalSecureStorage.readKey(
      key: StaticVariables.bluetoothKey,
    );

    if(bt != null) {
      LocalBluetoothJson btJson = LocalBluetoothJson.fromJson(jsonDecode(bt));

      if(btJson.bluetoothRemoteId != null) {
        connectedDevice = BluetoothDevice(
          remoteId: DeviceIdentifier(
            btJson.bluetoothRemoteId!,
          ),
        );
      }
    }
  }

  Future checkUntilDate() async {
    String? dateResult = await BookServices.showUntilDate(
      context: context, 
      startDate: fromDate, 
      duration: 14,
    );

    if(dateResult != null) {
      setState(() {
        untilDate = dateResult;
      });
    }
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
        eventChannelStreamSubscription =
            const EventChannel('intidata.android/library_app_event')
                .receiveBroadcastStream()
                .listen((data) async {
              if (!scannedRFID.contains(data.toString().substring(0, 16))) {
                setState(() {
                  scannedRFID.add(data.toString().substring(0, 16));
                });

                if(mounted) {
                  BookDataJson? bookResult = await BookServices.showBookByRFID(
                    context: context,
                    rfid: data.toString().substring(0, 16),
                  );

                  if (mounted && bookResult != null && bookResult.isAvailable == true) {
                    setState(() {
                      bookDataList.add(bookResult);
                    });

                    List<Map> tempBookDataList = [];

                    for (int i = 0; i < bookDataList.length; i++) {
                      tempBookDataList.add(bookDataList[i].toJson());
                    }

                    DisplayMonitorServices.sendStateToMonitor(
                      "READ_RFID",
                      {
                        "library_member": widget.libraryMemberData.toJson(),
                        "book_list": tempBookDataList,
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
    if(eventChannelStreamSubscription != null && isOnListen == true) {
      setState(() {
        eventChannelStreamSubscription!.cancel();
      });

      changeOnListenStatus();
    }
  }

  Future borrowBook() async {
    LocalDialogFunction.loadingDialog(context: context);

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
      if(mounted) {
        LocalRouteNavigator.closeBack(context: context); 
      }

      tempEventChannelStreamSubscription.cancel();

      bool isAccepted = true;

      for(int i = 0; i < confirmBookDataList.length; i++) {
        if(confirmBookDataList[i].keys.first == false) {
          isAccepted = false;

          break;
        }
      }

      if(isAccepted == true) {
        List<String> epcList = [];

        for(int i = 0; i < bookDataList.length; i++) {
          if(bookDataList[i].id != null && bookDataList[i].rfidTag != null) {
            epcList.add(bookDataList[i].rfidTag!);
          }
        }
        
        if(mounted) {
          bool postAlarmResult = await ControlGateServices.postAlarmToGate(
            context: context,
            epc: epcList,
          );

          if (mounted && postAlarmResult == true) {
            bool borrowResult = await BookServices.borrowBook(
              context: context,
              fromDate: fromDate,
              untilDate: untilDate,
              itemList: itemList,
              studentId: studentId,
              employeeId: employeeId,
            );

            if (mounted && borrowResult == true) {
              LocalRouteNavigator.moveTo(
                context: context,
                target: const ThanksPage(
                  type: 0,
                ),
                callbackFunction: (_) {
                  LocalRouteNavigator.closeBack(context: context);
                },
              );
            } else {
              clearScannedRFIDList();
              
              try {
                if(mounted) {
                  await ControlGateServices.deleteAlarmFromGate(
                    context: context,
                    epc: epcList,
                  );
                  
                  startRFIDAuto();
                }
              } catch(e) {
                debugPrint("err $e");
                
                startRFIDAuto();
              }
            }
          } else {
            clearScannedRFIDList();

            if(mounted) {
              LocalDialogFunction.okDialog(
                context: context,
                contentText: 'Failed to communicating with gate system, please try again!',
                onClose: () => startRFIDAuto(),
              );
            }
          }
        }
      } else {
        clearScannedRFIDList();

        if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Please do not remove books from Scanner before process is completed!',
            onClose: () => startRFIDAuto(),
          );
        }
      }
    });
  }

  void clearScannedRFIDList() {
    if(mounted) {
      setState(() {
        scannedRFID.clear();
        bookDataList.clear();
      });
    }

    DisplayMonitorServices.sendStateToMonitor(
      "READ_RFID",
      {
        "library_member": widget.libraryMemberData.toJson(),
        "book_list": {},
      },
    );
  }

  void checkIfStudentBorrow() {
    if(widget.libraryMemberData.nis != null) {
      borrowBook();
    } else if(widget.libraryMemberData.nik != null) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Select return date before proceed",
        onClose: () async {
          DateTime? datePicked = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2080),
            helpText: "RETURN DATE",
          );

          if(mounted && datePicked != null) {
            setState(() {
              untilDate = DateFormat("yyyy-MM-dd").format(datePicked);
            });

            borrowBook();
          } else if(mounted) {
            LocalDialogFunction.okDialog(
              context: context,
              contentText: 'Please select returning date before proceed',
            );
          }
        },
      );
    }
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