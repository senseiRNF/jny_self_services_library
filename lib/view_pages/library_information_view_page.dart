import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/library_information_page_controller.dart';

class LibraryInformationViewPage extends StatelessWidget {
  final LibraryInformationPageController controller;

  const LibraryInformationViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Library Information",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            "Library Contributors",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          MediaQuery.of(context).orientation == Orientation.landscape ?
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/library_info_1.jpeg',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/library_info_2.jpeg',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) :
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/library_info_1.jpeg',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/library_info_2.jpeg',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            "Library Membership",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Membership at the JNY library is available to students, teachers, and active staff who are part of the JNY community."
                "\nTo borrow a book, simply use the JNY-issued ID card.",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            "Library Collection",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "The JNY Library offers a diverse collection designed to meet the needs of readers from various backgrounds and interests. "
                "From academic textbooks to the latest fiction novels, we provide access to thousands of titles in various languages and genres."
                "\nOur collection is continuously updated to reflect the latest developments in the fields of science, technology, literature, and history.",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}