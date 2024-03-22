import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/dropdown_page_controller.dart';

class DropdownViewPage extends StatelessWidget {
  final DropdownPageController controller;
  final String title;

  const DropdownViewPage({
    super.key,
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: ListView.builder(
        itemCount: controller.widget.subjectList != null ? controller.widget.subjectList!.length :
        controller.widget.languageList != null ? controller.widget.languageList!.length : 0,
        itemBuilder: (context, index) {
          return controller.widget.subjectList != null ?
          Card(
            elevation: 5.0,
            child: InkWell(
              onTap: () => controller.pickSelected(controller.widget.subjectList![index]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  controller.widget.subjectList![index].name ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ) :
          controller.widget.languageList != null ?
          Card(
            elevation: 5.0,
            child: InkWell(
              onTap: () => controller.pickSelected(controller.widget.languageList![index]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  controller.widget.languageList![index].name ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ) :
          const Material();
        },
      ),
    );
  }
}