import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/borrowed_book_list_page_controller.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/account_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) => checkBorrowedBook());
  }

  void checkBorrowedBook() async {
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
      status:  "all",
    );

    List<BorrowedDetailDataJson> tempBorrowedList = [];
    List<BorrowedDetailDataJson> tempHistoryList = [];

    List<Map> tempBorrowedListMap = [];
    List<Map> tempHistoryListMap = [];

    if(borrowedDetailJson?.borrowedDetailDataJson != null) {

      for(int i = 0; i < (borrowedDetailJson?.borrowedDetailDataJson ?? []).length; i++) {
        if(borrowedDetailJson?.borrowedDetailDataJson?[i].status != null && borrowedDetailJson?.borrowedDetailDataJson?[i].status?.toLowerCase() == "returned") {
          if(i <= 5) {
            tempHistoryListMap.add(borrowedDetailJson!.borrowedDetailDataJson![i].toJson());
            tempHistoryList.add(borrowedDetailJson.borrowedDetailDataJson![i]);
          }
        } else if(borrowedDetailJson?.borrowedDetailDataJson?[i].status != null) {
          tempBorrowedListMap.add(borrowedDetailJson!.borrowedDetailDataJson![i].toJson());
          tempBorrowedList.add(borrowedDetailJson.borrowedDetailDataJson![i]);
        }
      }
    }

    if(mounted) {
      setState(() {
        borrowedList = tempBorrowedList;
        historyList = tempHistoryList;
      });
    }

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
  }

  void openListOfBorrowedBook(List<BorrowedBooksDataJson> bookList) {
    LocalRouteNavigator.moveTo(
      context: context,
      target: BorrowedBookListPage(
        title: "Borrowed - Book List",
        libraryMemberData: widget.libraryMemberData,
        bookList: bookList,
      ),
      callbackFunction: (_) => checkBorrowedBook(),
    );
  }

  void openListOfHistory(List<BorrowedBooksDataJson> historyList) {
    LocalRouteNavigator.moveTo(
      context: context,
      target: BorrowedBookListPage(
        title: "History - Book List",
        libraryMemberData: widget.libraryMemberData,
        bookList: historyList,
      ),
      callbackFunction: (_) => checkBorrowedBook(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AccountViewPage(controller: this);
  }
}