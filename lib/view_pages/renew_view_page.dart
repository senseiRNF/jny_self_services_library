import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/renew_page_controller.dart';

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
                        controller.widget.libraryMemberData.nis != null ?
                        Text(
                          controller.widget.libraryMemberData.nis!,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ) :
                        const Material(),
                        controller.widget.libraryMemberData.className != null ?
                        Text(
                          controller.widget.libraryMemberData.className!,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ) :
                        const Material(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller.listBorrowedDetail.isNotEmpty ?
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.listBorrowedDetail.length,
              itemBuilder: (BuildContext listContext, int index) {
                return Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                        controller.listBorrowedDetail[index].books != null ?
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.listBorrowedDetail[index].books!.length,
                          separatorBuilder: (separatorContext, separatorIndex) {
                            return const SizedBox(
                              height: 5.0,
                            );
                          },
                          itemBuilder: (subListContext, subIndex) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80.0,
                                  height: 80.0,
                                  child: CachedNetworkImage(
                                    imageUrl: controller.listBorrowedDetail[index].books![subIndex].url ?? "",
                                    fit: BoxFit.contain,
                                    errorWidget: (errContext, _, errObj) {
                                      return Icon(
                                        Icons.book,
                                        color: Theme.of(context).colorScheme.primary,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        controller.listBorrowedDetail[index].books![subIndex].bibliography!.title ?? 'Unknown',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "ISBN/ISSN: ${controller.listBorrowedDetail[index].books![subIndex].bibliography!.isbnOrIssn ?? 'Unknown'}",
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Authors: ',
                                          ),
                                          Text(
                                            controller.listBorrowedDetail[index].books![subIndex].bibliography != null ?
                                            controller.listBorrowedDetail[index].books![subIndex].bibliography!.authorNames ?? 'Unknown' :
                                            'Unknown',
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Publisher: ${controller.listBorrowedDetail[index].books![subIndex].bibliography != null
                                                  && controller.listBorrowedDetail[index].books![subIndex].bibliography!.publisher != null ?
                                              controller.listBorrowedDetail[index].books![subIndex].bibliography!.publisher!.name ?? 'Unknown' :
                                              "Unknown"} ',
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Publishing Year: ${controller.listBorrowedDetail[index].books![subIndex].bibliography != null ?
                                              controller.listBorrowedDetail[index].books![subIndex].bibliography!.publishingYear ?? 'Unknown' :
                                              "Unknown"} ',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ) :
                        const Material(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          onPressed: () => controller.renewBook(controller.listBorrowedDetail[index]),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                            child: Text(
                              'Renew Books',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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