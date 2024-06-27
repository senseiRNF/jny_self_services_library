import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/thanks_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/renew_view_page.dart';

class RenewPage extends StatefulWidget {
  final LibraryMemberData libraryMemberData;

  const RenewPage({
    super.key,
    required this.libraryMemberData,
  });

  @override
  State<RenewPage> createState() => RenewPageController();
}

class RenewPageController extends State<RenewPage> {
  List<BorrowedDetailDataJson> listBorrowedDetail = [];

  String fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String untilDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    checkUntilDate().then((_) => checkBorrowedBook());
  }

  checkUntilDate() async {
    await BookServices(context: context).showUntilDate(fromDate, 14).then((dateResult) {
      if(dateResult != null) {
        setState(() {
          untilDate = dateResult;
        });
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
        "SHOW_RENEW",
        {
          "library_member": widget.libraryMemberData.toJson(),
          "book_list": tempConvertedList,
        },
      );
    });
  }

  renewBook(BorrowedDetailDataJson listBorrowedDetail) async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    String itemList = "";

    if(listBorrowedDetail.books != null) {
      for(int i = 0; i < listBorrowedDetail.books!.length; i++) {
        if(listBorrowedDetail.books![i].id != null) {
          itemList = itemList.isNotEmpty ? "$itemList,${listBorrowedDetail.books![i].id!.toString()}" : listBorrowedDetail.books![i].id!.toString();
        }
      }
    }

    await BookServices(context: context).extendPeriodBook(listBorrowedDetail.id, untilDate, itemList, studentId, employeeId).then((result) {
      if(result == true) {
        MoveTo(
          context: context,
          target: const ThanksPage(
            type: 2,
          ),
          callback: (_) => CloseBack(context: context).go(),
        ).go();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RenewViewPage(controller: this);
  }
}