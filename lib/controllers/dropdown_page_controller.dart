import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:jny_self_services_library/view_pages/dropdown_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class DropdownPage extends StatefulWidget {
  final String title;
  final List<SubjectListDataJson>? subjectList;
  final List<LanguageListDataJson>? languageList;

  const DropdownPage({
    super.key,
    required this.title,
    this.subjectList,
    this.languageList
  });

  @override
  State<DropdownPage> createState() => DropdownPageController();
}

class DropdownPageController extends State<DropdownPage> {

  void pickSelected(dynamic result) => LocalRouteNavigator.closeBack(
    context: context,
    callbackResult: result,
  );

  @override
  Widget build(BuildContext context) {
    return DropdownViewPage(
      controller: this,
      title: widget.title,
    );
  }
}