import 'package:flutter/material.dart';
import 'package:jny_self_services_library/view_pages/example_view_page.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => ExamplePageController();
}

class ExamplePageController extends State<ExamplePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleViewPage(controller: this);
  }
}