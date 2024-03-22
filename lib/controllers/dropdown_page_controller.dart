import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/jsons/language_list_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/subjects_list_json.dart';
import 'package:jny_self_services_library/view_pages/dropdown_view_page.dart';

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

  pickSelected(dynamic result) => CloseBack(context: context, callbackData: result).go();

  @override
  Widget build(BuildContext context) {
    return DropdownViewPage(
      controller: this,
      title: widget.title,
    );
  }
}