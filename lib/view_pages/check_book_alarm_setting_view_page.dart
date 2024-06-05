import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/check_book_alarm_setting_page_controller.dart';

class CheckBookAlarmSettingViewPage extends StatelessWidget {
  final CheckBookAlarmSettingPageController controller;

  const CheckBookAlarmSettingViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Check Book Alarm',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          controller.bookDataJson != null ?
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: CachedNetworkImage(
                        imageUrl: controller.bookDataJson != null ? controller.bookDataJson!.mediaPath ?? '' : '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Alarm Status: ',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      controller.bookDataJson!.isAvailable != null && controller.bookDataJson!.isAvailable! == true ? 'Active' : 'Inactive',
                      style: TextStyle(
                        color: controller.bookDataJson != null ? controller.bookDataJson!.isAvailable != null && controller.bookDataJson!.isAvailable! == true ? Colors.green : Colors.red : Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) :
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Alarm Status: ',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Unknown',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
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