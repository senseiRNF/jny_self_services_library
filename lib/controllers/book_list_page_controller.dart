import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/view_pages/book_list_view_page.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => BookListPageController();
}

class BookListPageController extends State<BookListPage> {
  List<BookDataJson> bookList = [];
  List<BookDataJson> queryBookList = [];

  TextEditingController searchQueryTEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadBookList();
  }

  loadBookList() async => await BookServices(context: context).showAllBook().then((bookResult) {
    setState(() {
      bookList = bookResult;
    });

    if(searchQueryTEC.text != '') {
      List<BookDataJson> tempQueryBookList = [];

      for(int i = 0; i < bookResult.length; i++) {
        if(bookResult[i].title != null && bookResult[i].authorNames != null) {
          if(bookResult[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) || bookResult[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase())) {
            tempQueryBookList.add(bookResult[i]);
          }
        }
      }

      setState(() {
        queryBookList = tempQueryBookList;
      });
    } else {
      setState(() {
        queryBookList = bookResult;
      });
    }
  });

  searchBook() {
    List<BookDataJson> tempQueryBookList = [];

    if(searchQueryTEC.text != '') {
      for(int i = 0; i < bookList.length; i++) {
        if(bookList[i].title != null && bookList[i].authorNames != null) {
          if(bookList[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) || bookList[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase())) {
            tempQueryBookList.add(bookList[i]);
          }
        }
      }
    } else {
      tempQueryBookList = bookList;
    }

    setState(() {
      queryBookList = tempQueryBookList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BookListViewPage(controller: this);
  }
}