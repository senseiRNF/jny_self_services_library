import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String helloWorld = "Hello World";

  @override
  Widget build(BuildContext context) {
    return TestPageView(controller: this);
  }
}

class TestPageView extends StatelessWidget {
  final TestPageState controller;

  const TestPageView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        controller.helloWorld,
      ),
    );
  }
}