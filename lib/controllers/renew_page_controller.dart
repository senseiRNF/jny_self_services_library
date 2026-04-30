import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jny_self_services_library/controllers/thanks_page_controller.dart';
import 'package:jny_self_services_library/services/networks/book_services.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/services/networks/jsons/borrowed_books_json.dart';
import 'package:jny_self_services_library/services/networks/jsons/library_member_json.dart';
import 'package:jny_self_services_library/view_pages/renew_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class RenewPage extends StatefulWidget {
  final LibraryMemberData libraryMemberData;

  const RenewPage({
    super.key,
    required this.libraryMemberData,
  });

  @override
  State<RenewPage> createState() => RenewPageController();
}

class RenewPageController extends State<RenewPage> {
  List<BorrowedDetailDataJson> listBorrowedDetail = [];

  String fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String untilDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkUntilDate();

      checkBorrowedBook();
    });
  }

  Future checkUntilDate() async {
    String? untilDateResult = await BookServices.showUntilDate(
      context: context, startDate: fromDate, duration: 14,
    );

    if(mounted && untilDateResult != null) {
      setState(() {
        untilDate = untilDateResult;
      });
    }
  }

  Future checkBorrowedBook() async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    BorrowedDetailJson? currentBorrow = await BookServices.checkCurrentBorrow(
      context: context,
      studentId: studentId,
      employeeId: employeeId,
      status: "on loan",
    );

    List<BorrowedDetailDataJson> tempList = [];
    List<Map> tempConvertedList = [];

    for(BorrowedDetailDataJson data in currentBorrow?.borrowedDetailDataJson ?? []) {
      tempList.add(data);
      tempConvertedList.add(data.toJson());
    }

    if(mounted) {
      setState(() {
        listBorrowedDetail = tempList;
      });
    }

    DisplayMonitorServices.sendStateToMonitor(
      "SHOW_RENEW",
      {
        "library_member": widget.libraryMemberData.toJson(),
        "book_list": tempConvertedList,
      },
    );
  }

  void renewBook(BorrowedDetailDataJson listBorrowedDetail) async {
    String? studentId;
    String? employeeId;

    if(widget.libraryMemberData.nis != null) {
      studentId = widget.libraryMemberData.id!.toString();
    } else if(widget.libraryMemberData.nik != null) {
      employeeId = widget.libraryMemberData.id!.toString();
    }

    String itemList = "";

    if(listBorrowedDetail.books != null) {
      for(int i = 0; i < listBorrowedDetail.books!.length; i++) {
        if(listBorrowedDetail.books![i].id != null) {
          itemList = itemList.isNotEmpty ? "$itemList,${listBorrowedDetail.books![i].id!.toString()}" : listBorrowedDetail.books![i].id!.toString();
        }
      }
    }

    bool extended = await BookServices.extendPeriodBook(
      context: context,
      borrowId: listBorrowedDetail.id,
      untilDate: untilDate,
      itemList: itemList,
      studentId: studentId,
      employeeId: employeeId,
    );

    if(mounted && extended) {
      LocalRouteNavigator.moveTo(
        context: context,
        target: const ThanksPage(type: 2),
        callbackFunction: (_) => LocalRouteNavigator.closeBack(
          context: context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RenewViewPage(controller: this);
  }
}