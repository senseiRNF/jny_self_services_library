import 'package:flutter/material.dart';
import 'package:jny_self_services_library/view_pages/library_information_view_page.dart';

class LibraryInformationPage extends StatefulWidget {
  const LibraryInformationPage({super.key});

  @override
  State<LibraryInformationPage> createState() => LibraryInformationPageController();
}

class LibraryInformationPageController extends State<LibraryInformationPage> {
  int bookCount = 0;

  @override
  void initState() {
    super.initState();

    loadLibraryInformation();
  }

  loadLibraryInformation() async {

  }

  @override
  Widget build(BuildContext context) {
    return LibraryInformationViewPage(controller: this);
  }
}