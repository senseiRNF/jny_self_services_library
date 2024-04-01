import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrow_history_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:jny_self_services_library/view_pages/monitor_setup_view_page.dart';
import 'package:pocketbase/pocketbase.dart';

class MonitorSetupPage extends StatefulWidget {
  const MonitorSetupPage({super.key});

  @override
  State<MonitorSetupPage> createState() => MonitorSetupPageController();
}

class MonitorSetupPageController extends State<MonitorSetupPage> {
  TextEditingController pairingIDTEC = TextEditingController();

  PocketBase pbConfig = PocketBaseConfig.pb;

  List<Map<String, Map>> testingList = [
    {
      "IDLE": {
        "library_member": {},
        "book_list": {},
      },
    },
    {
      "BORROW": {
        "library_member": {},
        "book_list": {},
      },
    },
    {
      "RENEW": {
        "library_member": {},
        "book_list": {},
      },
    },
    {
      "RETURN": {
        "library_member": {},
        "book_list": {},
      },
    },
    {
      "SCAN_QR": {
        "library_member": {},
        "book_list": {},
      },
    },
    {
      "READ_RFID": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BookDataJson(
            id: 0,
            title: "Testing Book",
            isbnOrIssn: "0123abcd456",
            publisher: "Testing Publisher",
            publishingYear: "2024",
            authorNames: "Author, Testing",
            code: "TST123",
            location: "Testing Location",
            mediaPath: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_BORROWED": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedDetailDataJson(
            id: 0,
            fromDate: "2024-03-22",
            untilDate: "2024-03-28",
            status: "On Loan",
            books: [
              BorrowedBooksDataJson(
                id: 0,
                bibliography: Bibliography(
                  id: 0,
                  title: "Testing Book",
                  isbnOrIssn: "0123abcd456",
                  publishingYear: "2024",
                ),
              ),
            ],
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_BORROWED_LIST": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedBooksDataJson(
            id: 0,
            bibliography: Bibliography(
              id: 0,
              title: "Testing Book",
              isbnOrIssn: "0123abcd456",
              publishingYear: "2024",
            ),
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_BOOK_DETAIL": {
        "library_member": {},
        "book_list": BookDataJson(
          id: 0,
          title: "Testing Book",
          isbnOrIssn: "0123abcd456",
          publisher: "Testing Publisher",
          publishingYear: "2024",
          authorNames: "Author, Testing",
          code: "TST123",
          location: "Testing Location",
          mediaPath: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
        ).toJson(),
      },
    },
    {
      "SHOW_RENEW": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedDetailDataJson(
            id: 0,
            fromDate: "2024-03-22",
            untilDate: "2024-03-28",
            status: "On Loan",
            books: [
              BorrowedBooksDataJson(
                id: 0,
                bibliography: Bibliography(
                  id: 0,
                  title: "Testing Book",
                  isbnOrIssn: "0123abcd456",
                  publishingYear: "2024",
                ),
              ),
            ],
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_RENEW_LIST": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedBooksDataJson(
            id: 0,
            bibliography: Bibliography(
              id: 0,
              title: "Testing Book",
              isbnOrIssn: "0123abcd456",
              publishingYear: "2024",
            ),
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_RETURN": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedDetailDataJson(
            id: 0,
            fromDate: "2024-03-22",
            untilDate: "2024-03-28",
            status: "On Loan",
            books: [
              BorrowedBooksDataJson(
                id: 0,
                bibliography: Bibliography(
                  id: 0,
                  title: "Testing Book",
                  isbnOrIssn: "0123abcd456",
                  publishingYear: "2024",
                ),
              ),
            ],
          ).toJson(),
        ],
      },
    },
    {
      "SHOW_RETURN_LIST": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list":[
          {
            "scanned": false,
            "book_data": BorrowedBooksDataJson(
              id: 0,
              bibliography: Bibliography(
                id: 0,
                title: "Testing Book",
                isbnOrIssn: "0123abcd456",
                publishingYear: "2024",
              ),
            ).toJson(),
          },
        ],
      },
    },
    {
      "SHOW_BORROWED": {
        "library_member": LibraryMemberData(
          id: 0,
          nis: "1234567890",
          name: "Student Testing",
          className: "Class ABC",
          photoUrl: "https://tr.rbxcdn.com/e524036ceadee92ed24d562206d9a881/420/420/Hat/Png",
        ).toJson(),
        "book_list": [
          BorrowedDetailDataJson(
            id: 0,
            fromDate: "2024-03-22",
            untilDate: "2024-03-28",
            status: "On Loan",
            books: [
              BorrowedBooksDataJson(
                id: 0,
                bibliography: Bibliography(
                  id: 0,
                  title: "Testing Book",
                  isbnOrIssn: "0123abcd456",
                  publishingYear: "2024",
                ),
              ),
            ],
          ).toJson(),
        ],
        "history": [
          BorrowHistoryDataJson(
            id: 0,
            studentId: 0,
            fromDate: "2024-04-01",
            untilDate: "2024-04-05",
            status: "Returned",
            items: [
              Items(
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
                title: "Testing Book",
              ),
            ],
          ).toJson(),
        ],
      },
    },
  ];

  @override
  void initState() {
    super.initState();

    checkPairingID();
  }

  Future checkPairingID() async {
    await SharedPrefsFunctions.readData('pairingID').then((pairingIDResult) {
      if(pairingIDResult != null && pairingIDResult != '') {
        setState(() {
          pairingIDTEC.text = pairingIDResult;
        });
      }
    });
  }

  savePairingID() async {
    await SharedPrefsFunctions.writeData('pairingID', pairingIDTEC.text).then((writeResult) {
      if(writeResult == true) {
        OkDialog(
          context: context,
          content: "Success saving Pairing ID",
          headIcon: true,
          okPressed: () => CloseBack(context: context).go(),
        ).show();
      } else {
        OkDialog(
          context: context,
          content: "Failed to save Pairing ID",
          headIcon: false,
        ).show();
      }
    });
  }

  updateState(String state, Map args) async => await DisplayMonitorServices.sendStateToMonitor(state, args);

  @override
  Widget build(BuildContext context) {
    return MonitorSetupViewPage(controller: this);
  }
}