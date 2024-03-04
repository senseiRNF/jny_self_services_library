import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
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

  late String assetPath = widget.type == 0 ?
  'assets/images/thank_you_borrow.png' :
  widget.type == 1 ?
  'assets/images/thank_you_return.png' :
  'assets/images/thank_you_renew.png';

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