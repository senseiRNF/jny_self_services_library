import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/borrow_page_controller.dart';

class BorrowViewPage extends StatelessWidget {
  final BorrowPageController controller;

  const BorrowViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Borrow',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: controller.widget.libraryMemberData.photoUrl ?? '',
                      width: MediaQuery.of(context).size.width / 12,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          controller.widget.libraryMemberData.name ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          controller.widget.libraryMemberData.nis ?? controller.widget.libraryMemberData.nik ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          controller.widget.libraryMemberData.className ?? controller.widget.libraryMemberData.email ?? '',
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.bookDataList.isEmpty ?
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Place the book in the scanner to continue',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/images/gifs/books.gif',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ) :
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.bookDataList.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 16,
                              child: CachedNetworkImage(
                                imageUrl: controller.bookDataList[index].mediaPath ?? '',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controller.bookDataList[index].title ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "ISBN/ISSN: ${controller.bookDataList[index].isbnOrIssn ?? 'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Authors: ',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        controller.bookDataList[index].authorNames ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Publisher: ${controller.bookDataList[index].publisher ?? 'Unknown'} ',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Publishing Year: ${controller.bookDataList[index].publishingYear ?? 'Unknown'}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Total Books:",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${controller.bookDataList.length} Book",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.clearScannedRFIDList(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            elevation: 10.0,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                            child: Text(
                              'Rescan Books',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => controller.borrowBook(),
                          style: ElevatedButton.styleFrom(
                            elevation: 10.0,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                            child: Text(
                              'Confirm Books',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}