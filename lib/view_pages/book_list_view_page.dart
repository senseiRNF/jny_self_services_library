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
          "Book Search",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: controller.searchQueryTEC,
                  decoration: const InputDecoration(
                    labelText: "Search Book by 'Title', 'Authors' or 'ISBN/ISSN'",
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => controller.loadBookList(),
                  textInputAction: TextInputAction.search,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () => controller.openSubjectList(),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.selectedSubject.name ?? "Unknown",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () => controller.openLanguageList(),
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.selectedLanguage.name ?? "Unknown",
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: controller.bookList.isNotEmpty ?
            RefreshIndicator(
              onRefresh: () => controller.loadBookList(),
              child: ListView.builder(
                itemCount: controller.bookList.length,
                itemBuilder: (listContext, index) {
                  return Card(
                    elevation: 5.0,
                    child: InkWell(
                      onTap: () => controller.showBookDetail(controller.bookList[index]),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).orientation == Orientation.landscape ?
                              MediaQuery.of(context).size.width / 12 :
                              MediaQuery.of(context).size.width / 8,
                              child: CachedNetworkImage(
                                imageUrl: controller.bookList[index].mediaPath ?? '',
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
                                    controller.bookList[index].title ?? 'Unknown Title',
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
                                          controller.bookList[index].code ?? 'Unknown Code',
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
                                          controller.bookList[index].isbnOrIssn ?? 'Unknown',
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
                                          controller.bookList[index].authorNames ?? 'Unknown Authors',
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
                                          controller.bookList[index].publisher ?? 'Unknown Publisher',
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
                                          controller.bookList[index].publishingYear ?? 'Unknown',
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
                                          controller.bookList[index].location ?? '-',
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
                                        'Shelf Location: ',
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Text(
                                          controller.bookList[index].shelfLocation ?? '-',
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