import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/check_book_status_setting_page_controller.dart';

class CheckBookStatusSettingViewPage extends StatelessWidget {
  final CheckBookStatusSettingPageController controller;

  const CheckBookStatusSettingViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Book Status',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'RFID: ${controller.scannedRFID ?? "No Data Found"}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Alarm Status: ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                controller.bookDataJson != null
                    ? controller.bookDataJson!.isAvailable != null && controller.bookDataJson!.isAvailable! == true
                    ? 'Active' : 'Inactive'
                    : "No Data Found",
                style: TextStyle(
                  color: controller.bookDataJson != null ? controller.bookDataJson!.isAvailable != null && controller.bookDataJson!.isAvailable! == true ? Colors.lightGreen : Colors.red : Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          controller.bookDataJson != null ?
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.0,
                      child: CachedNetworkImage(
                        imageUrl: controller.bookDataJson != null ? controller.bookDataJson!.mediaPath ?? '' : '',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      children: [
                        Text(
                          'RFID: ${controller.scannedRFID ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Title: ${controller.bookDataJson!.title ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'ISBN/ISSN: ${controller.bookDataJson!.isbnOrIssn ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Authors: ${controller.bookDataJson!.authorNames ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Publisher: ${controller.bookDataJson!.publisher ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Publishing Year: ${controller.bookDataJson!.publishingYear ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Type: ${controller.bookDataJson!.type ?? 'Unknown'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Location: ${controller.bookDataJson!.location ?? '-'}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Shelf Location: ${controller.bookDataJson!.shelfLocation ?? '-'}',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Borrow History",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                controller.loanHistoryList.isNotEmpty ?
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (separatorContext, separatorIndex) {
                    return const SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: controller.loanHistoryList.length,
                  itemBuilder: (listContext, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "From Date: ${controller.loanHistoryList[index].fromDate != null
                                  ? DateFormat("EEEE, dd MMMM yyyy").format(DateTime.parse(controller.loanHistoryList[index].fromDate!))
                                  : "Unknown Date"}",
                            ),
                            Text(
                              "Until Date: ${controller.loanHistoryList[index].untilDate != null
                                  ? DateFormat("EEEE, dd MMMM yyyy").format(DateTime.parse(controller.loanHistoryList[index].untilDate!))
                                  : "Unknown Date"}",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            controller.loanHistoryList[index].student != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Borrowed By: ${controller.loanHistoryList[index].student!.name ?? "Unknown Student"}",
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NIS: ${controller.loanHistoryList[index].student!.nis ?? "-"}",
                                    ),
                                    Text(
                                      "   (STUDENT)",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ) :
                            controller.loanHistoryList[index].employee != null ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Borrowed By: ${controller.loanHistoryList[index].employee!.name ?? "Unknown Employee"}",
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NIK: ${controller.loanHistoryList[index].employee!.nik ?? "-"}",
                                    ),
                                    Text(
                                      "   (EMPLOYEE)",
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ) :
                            const Material(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  controller.loanHistoryList[index].status != null
                                      ? controller.loanHistoryList[index].status!
                                      : "Unknown Status",
                                  style: TextStyle(
                                    color: controller.loanHistoryList[index].status != null
                                        ? controller.loanHistoryList[index].status!.toLowerCase() == "returned"
                                        ? Colors.lightGreen
                                        : Theme.of(context).colorScheme.primary
                                        : Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ) :
                const Text(
                  "No Borrow History Found...",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ) :
          Expanded(
            child: Center(
              child: Text(
                controller.isLoadingData ? "Loading Data, Please Wait...." : "No Data Found",
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => controller.checkRFIDTagAlarm(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Text(
                  'Check Book Alarm',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}