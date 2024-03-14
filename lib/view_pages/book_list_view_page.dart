import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/book_list_page_controller.dart';

class BookListViewPage extends StatelessWidget {
  final BookListPageController controller;

  const BookListViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book Collections",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: TextField(
              controller: controller.searchQueryTEC,
              decoration: const InputDecoration(
                labelText: "Search Book by 'Title' or 'Authors'",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.searchBook(),
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: controller.queryBookList.isNotEmpty ?
            RefreshIndicator(
              onRefresh: () => controller.loadBookList(),
              child: ListView.builder(
                itemCount: controller.queryBookList.length,
                itemBuilder: (listContext, index) {
                  return Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).orientation == Orientation.landscape ?
                            MediaQuery.of(context).size.width / 12 :
                            MediaQuery.of(context).size.width / 8,
                            child: CachedNetworkImage(
                              imageUrl: controller.queryBookList[index].mediaPath ?? '',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  controller.queryBookList[index].title ?? 'Unknown Title',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Code: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].code ?? 'Unknown Code',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'ISBN/ISSN: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].isbnOrIssn ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Authors: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].authorNames ?? 'Unknown Authors',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Publisher: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].publisher ?? 'Unknown Publisher',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Publishing Year: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].publishingYear ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Location: ',
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        controller.queryBookList[index].location ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
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
                    ),
                  );
                },
              ),
            ) :
            Stack(
              children: [
                const Center(
                  child: Text(
                    "Books not found!",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RefreshIndicator(
                  onRefresh: () => controller.loadBookList(),
                  child: ListView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}