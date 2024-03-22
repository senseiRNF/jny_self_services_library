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
  int? borrowId;

  List<BorrowedDetailDataJson> listBorrowedDetail = [];
  List<BorrowedBooksDataJson> listBorrowedBooks = [];

  @override
  void initState() {
    super.initState();

    checkBorrowedBook();
  }

  Future checkBorrowedBook() async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    await BookServices(context: context).checkBorrowedBook(studentId, employeeId).then((result) {
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

  renewBook(int borrowId) async {
    String? studentId;
    String? employeeId;
    String extendUntilDate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 7)));

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    String itemList = "";

    for(int i = 0; i < listBorrowedBooks.length; i++) {
      if(listBorrowedBooks[i].id != null) {
        itemList = itemList.isNotEmpty ? "$itemList,${listBorrowedBooks[i].id!.toString()}" : listBorrowedBooks[i].id!.toString();
      }
    }

    await BookServices(context: context).extendPeriodBook(borrowId, extendUntilDate, itemList, studentId, employeeId).then((result) {
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

  showBorrowedBooks(int id, List<BorrowedBooksDataJson> listBooks) {
    List<BorrowedBooksDataJson> tempList = [];
    List<Map> tempConvertedList = [];

    for(int i = 0; i < listBooks.length; i++) {
      tempList.add(listBooks[i]);
      tempConvertedList.add(listBooks[i].toJson());
    }

    setState(() {
      listBorrowedBooks = tempList;
      borrowId = id;
    });

    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_RENEW_LIST",
      {
        "library_member": widget.libraryMemberData.toJson(),
        "book_list": tempConvertedList,
      },
    );
  }

  closeBorrowedBooks() {
    setState(() {
      listBorrowedBooks.clear();
      borrowId = null;
    });

    checkBorrowedBook();
  }

  @override
  Widget build(BuildContext context) {
    return RenewViewPage(controller: this);
  }
}