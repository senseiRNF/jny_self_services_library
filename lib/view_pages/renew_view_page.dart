import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/renew_page_controller.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';

class RenewViewPage extends StatelessWidget {
  final RenewPageController controller;

  const RenewViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Renew',
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
          controller.listBorrowedDetail.isNotEmpty ?
          controller.listBorrowedBooks.isEmpty ?
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.listBorrowedDetail.length,
              itemBuilder: (BuildContext listContext, int index) {
                return Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      if(controller.listBorrowedDetail[index].id != null && controller.listBorrowedDetail[index].books != null) {
                        List<BorrowedBooksDataJson> tempList = controller.listBorrowedDetail[index].books!;

                        controller.showBorrowedBooks(controller.listBorrowedDetail[index].id!, tempList);
                      }
                    },
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Borrow Date: ${controller.listBorrowedDetail[index].fromDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.listBorrowedDetail[index].fromDate!)) : "Unknown"}',
                                ),
                                Text(
                                  'Return Date: ${controller.listBorrowedDetail[index].untilDate != null ? DateFormat('EEEE, dd MMMM yyyy').format(DateTime.parse(controller.listBorrowedDetail[index].untilDate!)) : "Unknown"}',
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Status: ${controller.listBorrowedDetail[index].status ?? "Unknown"}',
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Number Of Books Borrowed: ${controller.listBorrowedDetail[index].books != null ? controller.listBorrowedDetail[index].books!.length : "Unknown"}',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Icon(
                            Icons.navigate_next,
                            size: 35.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ) :
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => controller.closeBorrowedBooks(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.listBorrowedBooks.length,
                    itemBuilder: (BuildContext listContext, int index) {
                      return controller.listBorrowedBooks[index].bibliography != null ?
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    controller.listBorrowedBooks[index].bibliography!.title ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "ISBN/ISSN: ${controller.listBorrowedBooks[index].bibliography!.isbnOrIssn ?? 'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                    ),
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () => controller.borrowId != null ?
                        controller.renewBook(controller.borrowId!) : {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                          child: Text(
                            'Renew Books',
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) :
          Expanded(
            child: Stack(
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Currently, no books are being borrowed',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Swipe down to refresh',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                RefreshIndicator(
                  onRefresh: () async => controller.checkBorrowedBook(),
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