import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/example_page_controller.dart';

class ExampleViewPage extends StatelessWidget {
  final ExamplePageController controller;

  const ExampleViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UHF EXAMPLE'),
      ),
      body: const Material(),
    );
  }
}