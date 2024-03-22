import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/networks/display_monitor_services.dart';
import 'package:jny_self_services_library/view_pages/thanks_view_page.dart';

class ThanksPage extends StatefulWidget {
  final int type;

  const ThanksPage({
    super.key,
    required this.type,
  });

  @override
  State<ThanksPage> createState() => ThanksPageController();
}

class ThanksPageController extends State<ThanksPage> {
  int countdownTime = 5;

  late Timer timer;

  late String assetPathLandscape = widget.type == 0 ?
  'assets/images/thank_you_borrow_landscape.png' :
  widget.type == 1 ?
  'assets/images/thank_you_return_landscape.png' :
  'assets/images/thank_you_renew_landscape.png';

  late String assetPathPortrait = widget.type == 0 ?
  'assets/images/thank_you_borrow_portrait.png' :
  widget.type == 1 ?
  'assets/images/thank_you_return_portrait.png' :
  'assets/images/thank_you_renew_portrait.png';

  @override
  void initState() {
    super.initState();

    setState(() {
      timer = Timer.periodic(const Duration(seconds: 1), (ticker) {
        setState(() {
          countdownTime = countdownTime - 1;
        });

        if(ticker.tick == 5) {
          timer.cancel();

          CloseBack(context: context).go();
        }
      });
    });

    switch(widget.type) {
      case 0:
        DisplayMonitorServices.sendStateToMonitor(
          "BORROW",
          {
            "library_member": {},
            "book_list": {},
          },
        );
        break;
      case 1:
        DisplayMonitorServices.sendStateToMonitor(
          "RETURN",
          {
            "library_member": {},
            "book_list": {},
          },
        );
        break;
      case 2:
        DisplayMonitorServices.sendStateToMonitor(
          "RENEW",
          {
            "library_member": {},
            "book_list": {},
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThanksViewPage(controller: this);
  }

  @override
  void dispose() {
    if(timer.isActive) {
      timer.cancel();
    }

    super.dispose();
  }
}