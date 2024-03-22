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
        "SHOW_BORROWED",
        {
          "library_member": widget.libraryMemberData.toJson(),
          "book_list": tempConvertedList,
        },
      );
    });
  }

  openListOfBorrowedBook(List<BorrowedBooksDataJson> bookList) {
    MoveTo(
      context: context,
      target: BorrowedBookListPage(
        bookList: bookList,
      ),
    ).go();
  }

  @override
  Widget build(BuildContext context) {
    return AccountViewPage(controller: this);
  }
}