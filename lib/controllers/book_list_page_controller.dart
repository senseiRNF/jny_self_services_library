import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/dropdown_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:jny_self_services_library/view_pages/book_list_view_page.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => BookListPageController();
}

class BookListPageController extends State<BookListPage> {
  List<BookDataJson> bookList = [];
  List<BookDataJson> queryBookList = [];

  List<SubjectListDataJson> subjectList = [
    SubjectListDataJson(
      id: 0,
      name: "All Subjects",
    ),
  ];

  List<LanguageListDataJson> languageList = [
    LanguageListDataJson(
      id: 0,
      name: "All Language",
    ),
  ];

  SubjectListDataJson selectedSubject = SubjectListDataJson(
    id: 0,
    name: "All Subjects",
  );
  LanguageListDataJson selectedLanguage = LanguageListDataJson(
    id: 0,
    name: "All Language",
  );

  TextEditingController searchQueryTEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadLanguage().then((_) => loadSubjects().then((_) async => loadBookList()));
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

  Future loadLanguage() async {
    List<LanguageListDataJson> tempLanguageList = [];

    await BookServices(context: context).showAllLanguage().then((languageResult) {
      tempLanguageList.add(
        LanguageListDataJson(
          id: 0,
          name: "All Language",
        ),
      );

      tempLanguageList.addAll(languageResult);
    });

    setState(() {
      languageList = tempLanguageList;
    });
  }

  Future loadSubjects() async {
    List<SubjectListDataJson> tempSubjectList = [];

    await BookServices(context: context).showAllSubjects().then((subjectResult) {
      tempSubjectList.add(
        SubjectListDataJson(
          id: 0,
          name: "All Subjects",
        ),
      );

      tempSubjectList.addAll(subjectResult);
    });

    setState(() {
      subjectList = tempSubjectList;
    });
  }

  searchBook() {
    List<BookDataJson> tempQueryBookList = [];

    if(searchQueryTEC.text != '') {
      for(int i = 0; i < bookList.length; i++) {
        if(bookList[i].title != null && bookList[i].authorNames != null && selectedSubject.id != 0 && selectedLanguage.id != 0) {
          if(bookList[i].subjectId != null && bookList[i].languageId != null) {
            List<String> subjectId = bookList[i].subjectId!.split(",").toList();
            bool subjectMatch = false;

            for(int x = 0; x < subjectId.length; x++) {
              if(int.parse(subjectId[x]) == selectedSubject.id!) {
                subjectMatch = true;
              }
            }

            if(bookList[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                bookList[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                (subjectMatch == true && bookList[i].languageId == selectedLanguage.id!)) {
              tempQueryBookList.add(bookList[i]);
            }
          }
        } else if(selectedSubject.id != 0) {
          if(bookList[i].title != null && bookList[i].authorNames != null && bookList[i].subjectId != null) {
            List<String> subjectId = bookList[i].subjectId!.split(",").toList();
            bool subjectMatch = false;

            for(int x = 0; x < subjectId.length; x++) {
              if(int.parse(subjectId[x]) == selectedSubject.id!) {
                subjectMatch = true;
              }
            }

            if(bookList[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                bookList[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                subjectMatch == true) {
              tempQueryBookList.add(bookList[i]);
            }
          }
        } else if(selectedLanguage.id != 0) {
          if(bookList[i].title != null && bookList[i].authorNames != null && bookList[i].languageId != null) {
            if(bookList[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                bookList[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) ||
                bookList[i].languageId == selectedLanguage.id!) {
              tempQueryBookList.add(bookList[i]);
            }
          }
        } else {
          if(bookList[i].title != null && bookList[i].authorNames != null) {
            if(bookList[i].title!.toLowerCase().contains(searchQueryTEC.text.toLowerCase()) || bookList[i].authorNames!.toLowerCase().contains(searchQueryTEC.text.toLowerCase())) {
              tempQueryBookList.add(bookList[i]);
            }
          }
        }
      }
    } else if(selectedSubject.id != 0 || selectedLanguage.id != 0) {
      for(int i = 0; i < bookList.length; i++) {
        if(selectedSubject.id != 0 && selectedLanguage.id != 0) {
          List<String> subjectId = bookList[i].subjectId!.split(",").toList();
          bool subjectMatch = false;

          for(int x = 0; x < subjectId.length; x++) {
            if(int.parse(subjectId[x]) == selectedSubject.id!) {
              subjectMatch = true;
            }
          }

          if(subjectMatch == true && bookList[i].languageId == selectedLanguage.id!) {
            tempQueryBookList.add(bookList[i]);
          }
        } else if(selectedSubject.id != 0) {
          if(bookList[i].subjectId != null) {
            List<String> subjectId = bookList[i].subjectId!.split(",").toList();
            bool subjectMatch = false;

            for(int x = 0; x < subjectId.length; x++) {
              if(int.parse(subjectId[x]) == selectedSubject.id!) {
                subjectMatch = true;
              }
            }

            if(subjectMatch == true) {
              tempQueryBookList.add(bookList[i]);
            }
          }
        } else if(selectedLanguage.id != 0) {
          if(bookList[i].languageId != null) {
            if(bookList[i].languageId == selectedLanguage.id!) {
              tempQueryBookList.add(bookList[i]);
            }
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

  showBookDetail(BookDataJson bookData) async {
    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_BOOK_DETAIL",
      {
        "library_member": {},
        "book_list": bookData.toJson(),
      },
    );
  }

  openSubjectList() => MoveTo(
    context: context,
    target: DropdownPage(
      title: "Subjects List",
      subjectList: subjectList,
    ),
    callback: (subject) {
      if(subject != null) {
        setState(() {
          selectedSubject = subject;
        });

        searchBook();
      }
    }
  ).go();

  openLanguageList() => MoveTo(
      context: context,
      target: DropdownPage(
        title: "Language List",
        languageList: languageList,
      ),
      callback: (language) {
        if(language != null) {
          setState(() {
            selectedLanguage = language;
          });

          searchBook();
        }
      }
  ).go();

  @override
  Widget build(BuildContext context) {
    return BookListViewPage(controller: this);
  }
}