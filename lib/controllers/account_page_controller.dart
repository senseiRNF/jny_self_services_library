import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/borrowed_book_list_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/account_view_page.dart';

class AccountPage extends StatefulWidget {
  final LibraryMemberData libraryMemberData;

  const AccountPage({
    super.key,
    required this.libraryMemberData,
  });

  @override
  State<AccountPage> createState() => AccountPageController();
}

class AccountPageController extends State<AccountPage> {
  List<BorrowedDetailDataJson> listBorrowedDetail = [];

  bool showLoading = false;

  @override
  void initState() {
    super.initState();

    checkBorrowedBook();
  }

  checkBorrowedBook() async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    await BookServices(context: context).checkCurrentBorrow(studentId, employeeId).then((result) async {
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

      await BookServices(context: context).showHistoryBorrow(studentId, employeeId).then((historyResult) {
        List<Map> tempBorrowList = [];

        for(int i = 0; i < historyResult.length; i++) {
          tempBorrowList.add(historyResult[i].toJson());
        }

        if(tempBorrowList.isNotEmpty) {
          DisplayMonitorServices.sendStateToMonitor(
            "SHOW_BORROWED",
            {
              "library_member": widget.libraryMemberData.toJson(),
              "book_list": tempConvertedList,
              "history": tempBorrowList,
            },
          );
        } else {
          DisplayMonitorServices.sendStateToMonitor(
            "SHOW_BORROWED",
            {
              "library_member": widget.libraryMemberData.toJson(),
              "book_list": tempConvertedList,
            },
          );
        }
      }).catchError((err) {
        DisplayMonitorServices.sendStateToMonitor(
          "SHOW_BORROWED",
          {
            "library_member": widget.libraryMemberData.toJson(),
            "book_list": tempConvertedList,
          },
        );
      });
    });
  }

  openListOfBorrowedBook(List<BorrowedBooksDataJson> bookList) {
    MoveTo(
      context: context,
      target: BorrowedBookListPage(
        libraryMemberData: widget.libraryMemberData,
        bookList: bookList,
      ),
      callback: (_) => checkBorrowedBook(),
    ).go();
  }

  @override
  Widget build(BuildContext context) {
    return AccountViewPage(controller: this);
  }
}