import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/borrowed_book_list_page_controller.dart';

class BorrowedBookListViewPage extends StatelessWidget {
  final BorrowedBookListPageController controller;

  const BorrowedBookListViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.widget.title,
        ),
      ),
      body: ListView.builder(
        itemCount: controller.widget.bookList.length,
        itemBuilder: (BuildContext listContext, int index) {
          return controller.widget.bookList[index].bibliography != null ?
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    imageUrl: controller.widget.bookList[index].url ?? '',
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
                        controller.widget.bookList[index].bibliography!.title ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "ISBN/ISSN: ${controller.widget.bookList[index].bibliography!.isbnOrIssn ?? 'Unknown'}",
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
                            controller.widget.bookList[index].bibliography != null ?
                            controller.widget.bookList[index].bibliography!.authorNames ?? 'Unknown' :
                            'Unknown',
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
                              'Publisher: ${controller.widget.bookList[index].bibliography != null
                                  && controller.widget.bookList[index].bibliography!.publisher != null ?
                              controller.widget.bookList[index].bibliography!.publisher!.name ?? 'Unknown' :
                              "Unknown"} ',
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Publishing Year: ${controller.widget.bookList[index].bibliography != null ?
                              controller.widget.bookList[index].bibliography!.publishingYear ?? 'Unknown' :
                              "Unknown"} ',
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
          ) :
          const Material();
        },
      ),
    );
  }
}