import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/dropdown_page_controller.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:jny_self_services_library/view_pages/book_list_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => BookListPageController();
}

class BookListPageController extends State<BookListPage> {
  List<BookDataJson> bookList = [];
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await loadLanguage();

      await loadSubjects();

      await loadBookList();
    });
  }

  Future loadBookList() async {
    List<BookDataJson> bookResult = await BookServices.showBookByFilter(
      context: context,
      parameter: searchQueryTEC.text,
    );

    if(selectedSubject.id != 0 || selectedLanguage.id != 0) {
      List<BookDataJson> tempBookList = [];

      for(int i = 0; i < bookResult.length; i++) {
        if(selectedSubject.id != 0 && selectedLanguage.id != 0) {
          List<String> subjectId = bookResult[i].subjectId!.split(",").toList();
          bool subjectMatch = false;

          for(int x = 0; x < subjectId.length; x++) {
            if(int.parse(subjectId[x]) == selectedSubject.id!) {
              subjectMatch = true;
            }
          }

          if(subjectMatch == true && bookResult[i].languageId == selectedLanguage.id!) {
            tempBookList.add(bookResult[i]);
          }
        } else if(selectedSubject.id != 0) {
          if(bookResult[i].subjectId != null) {
            List<String> subjectId = bookResult[i].subjectId!.split(",").toList();
            bool subjectMatch = false;

            for(int x = 0; x < subjectId.length; x++) {
              if(int.parse(subjectId[x]) == selectedSubject.id!) {
                subjectMatch = true;
              }
            }

            if(subjectMatch == true) {
              tempBookList.add(bookResult[i]);
            }
          }
        } else if(selectedLanguage.id != 0) {
          if(bookResult[i].languageId != null) {
            if(bookResult[i].languageId == selectedLanguage.id!) {
              tempBookList.add(bookResult[i]);
            }
          }
        }
      }

      setState(() {
        bookList = tempBookList;
      });
    } else {
      setState(() {
        bookList = bookResult;
      });
    }
  }

  Future loadLanguage() async {
    List<LanguageListDataJson> tempLanguageList = [
      LanguageListDataJson(
        id: 0,
        name: "All Language",
      ),
    ];

    List<LanguageListDataJson> languageResult = await BookServices.showAllLanguage(
      context: context
    );

    for(LanguageListDataJson data in languageResult) {
      tempLanguageList.add(data);
    }

    if(mounted) {
      setState(() {
        languageList = tempLanguageList;
      });
    }
  }

  Future loadSubjects() async {
    List<SubjectListDataJson> tempSubjectList = [
      SubjectListDataJson(
        id: 0,
        name: "All Subjects",
      ),
    ];

    List<SubjectListDataJson> subjectResult = await BookServices.showAllSubjects(
      context: context
    );

    for(SubjectListDataJson data in subjectResult) {
      tempSubjectList.add(data);
    }

    if(mounted) {
      setState(() {
        subjectList = tempSubjectList;
      });
    }
  }

  void showBookDetail(BookDataJson bookData) async {
    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_BOOK_DETAIL",
      {
        "library_member": {},
        "book_list": bookData.toJson(),
      },
    );
  }

  void openSubjectList() => LocalRouteNavigator.moveTo(
    context: context,
    target: DropdownPage(
      title: "Subjects List",
      subjectList: subjectList,
    ),
    callbackFunction: (subject) {
      if(mounted && subject != null) {
        setState(() {
          selectedSubject = subject;
        });

        loadBookList();
      }
    }
  );

  void openLanguageList() => LocalRouteNavigator.moveTo(
      context: context,
      target: DropdownPage(
        title: "Language List",
        languageList: languageList,
      ),
      callbackFunction: (language) {
        if(mounted && language != null) {
          setState(() {
            selectedLanguage = language;
          });

          loadBookList();
        }
      }
  );

  @override
  Widget build(BuildContext context) {
    return BookListViewPage(controller: this);
  }
}