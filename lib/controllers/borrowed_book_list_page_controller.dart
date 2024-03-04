import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/view_pages/borrowed_book_list_view_page.dart';

class BorrowedBookListPage extends StatefulWidget {
  final List<BorrowedBooksDataJson> bookList;

  const BorrowedBookListPage({
    super.key,
    required this.bookList,
  });

  @override
  State<BorrowedBookListPage> createState() => BorrowedBookListPageController();
}

class BorrowedBookListPageController extends State<BorrowedBookListPage> {
  @override
  Widget build(BuildContext context) {
    return BorrowedBookListViewPage(controller: this);
  }
}