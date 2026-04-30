import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/book_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/services/networks/pocket_base_config.dart';
import 'package:jny_self_services_library/view_pages/monitor_setup_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';
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
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
            url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
            url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
              url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
          BorrowedDetailDataJson(
            id: 0,
            fromDate: "2024-03-01",
            untilDate: "2024-03-05",
            status: "Returned",
            books: [
              BorrowedBooksDataJson(
                id: 0,
                url: "https://tr.rbxcdn.com/537c5ad362e65b2247cbef6be9f8de7d/420/420/Hat/Png",
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
      "INFORMATION": {
        "library_member": {},
        "book_list": {},
      },
    },
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => checkPairingID());
  }

  Future checkPairingID() async {
    String? pairingId = await LocalSecureStorage.readKey(
      key: StaticVariables.pairingIdKey,
    );

    if(mounted && pairingId != null) {
      setState(() {
        pairingIDTEC.text = pairingId;
      });
    }
  }

  void savePairingID() async {
    bool writeResult = await LocalSecureStorage.writeKey(
      key: StaticVariables.pairingIdKey,
      data: pairingIDTEC.text,
    );

    if(mounted && writeResult == true) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Success saving Pairing ID",
        onClose: () => LocalRouteNavigator.closeBack(
          context: context,
        ),
      );
    } else if(mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: "Failed to save Pairing ID",
      );
    }
  }

  void updateState(String state, Map args) async => await DisplayMonitorServices
      .sendStateToMonitor(state, args);

  @override
  Widget build(BuildContext context) {
    return MonitorSetupViewPage(controller: this);
  }
}