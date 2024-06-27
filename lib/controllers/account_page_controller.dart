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
  List<BorrowedDetailDataJson> borrowedList = [];
  List<BorrowedDetailDataJson> historyList = [];

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

    await BookServices(context: context).checkCurrentBorrow(studentId, employeeId, "all").then((result) async {
      List<BorrowedDetailDataJson> tempBorrowedList = [];
      List<BorrowedDetailDataJson> tempHistoryList = [];

      List<Map> tempBorrowedListMap = [];
      List<Map> tempHistoryListMap = [];

      if(result != null && result.borrowedDetailDataJson != null) {
        for(int i = 0; i < result.borrowedDetailDataJson!.length; i++) {
          if(result.borrowedDetailDataJson![i].status != null && result.borrowedDetailDataJson![i].status!.toLowerCase() == "returned") {
            if(i <= 5) {
              tempHistoryListMap.add(result.borrowedDetailDataJson![i].toJson());
              tempHistoryList.add(result.borrowedDetailDataJson![i]);
            }
          } else if(result.borrowedDetailDataJson![i].status != null) {
            tempBorrowedListMap.add(result.borrowedDetailDataJson![i].toJson());
            tempBorrowedList.add(result.borrowedDetailDataJson![i]);
          }
        }
      }

      setState(() {
        borrowedList = tempBorrowedList;
        historyList = tempHistoryList;
      });

      if(tempHistoryList.isNotEmpty) {
        DisplayMonitorServices.sendStateToMonitor(
          "SHOW_BORROWED",
          {
            "library_member": widget.libraryMemberData.toJson(),
            "book_list": tempBorrowedListMap,
            "history": tempHistoryListMap,
          },
        );
      } else {
        DisplayMonitorServices.sendStateToMonitor(
          "SHOW_BORROWED",
          {
            "library_member": widget.libraryMemberData.toJson(),
            "book_list": tempBorrowedListMap,
          },
        );
      }
    });
  }

  openListOfBorrowedBook(List<BorrowedBooksDataJson> bookList) {
    MoveTo(
      context: context,
      target: BorrowedBookListPage(
        title: "Borrowed - Book List",
        libraryMemberData: widget.libraryMemberData,
        bookList: bookList,
      ),
      callback: (_) => checkBorrowedBook(),
    ).go();
  }

  openListOfHistory(List<BorrowedBooksDataJson> historyList) {
    MoveTo(
      context: context,
      target: BorrowedBookListPage(
        title: "History - Book List",
        libraryMemberData: widget.libraryMemberData,
        bookList: historyList,
      ),
      callback: (_) => checkBorrowedBook(),
    ).go();
  }

  @override
  Widget build(BuildContext context) {
    return AccountViewPage(controller: this);
  }
}