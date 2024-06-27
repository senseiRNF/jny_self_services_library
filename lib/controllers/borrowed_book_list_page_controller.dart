import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/borrowed_book_list_view_page.dart';

class BorrowedBookListPage extends StatefulWidget {
  final String title;
  final LibraryMemberData libraryMemberData;
  final List<BorrowedBooksDataJson> bookList;

  const BorrowedBookListPage({
    super.key,
    required this.title,
    required this.libraryMemberData,
    required this.bookList,
  });

  @override
  State<BorrowedBookListPage> createState() => BorrowedBookListPageController();
}

class BorrowedBookListPageController extends State<BorrowedBookListPage> {
  List<BorrowedBooksDataJson> listBorrowedBooks = [];

  @override
  void initState() {
    super.initState();

    showBorrowedBooks();
  }

  showBorrowedBooks() {
    List<BorrowedBooksDataJson> tempList = [];
    List<Map> tempConvertedList = [];

    for(int i = 0; i < widget.bookList.length; i++) {
      tempList.add(widget.bookList[i]);
      tempConvertedList.add(widget.bookList[i].toJson());
    }

    setState(() {
      listBorrowedBooks = tempList;
    });

    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_BORROWED_LIST",
      {
        "library_member": widget.libraryMemberData.toJson(),
        "book_list": tempConvertedList,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BorrowedBookListViewPage(controller: this);
  }
}