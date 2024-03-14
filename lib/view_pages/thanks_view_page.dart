import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/thanks_page_controller.dart';

class ThanksViewPage extends StatelessWidget {
  final ThanksPageController controller;

  const ThanksViewPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) {},
        child: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  MediaQuery.of(context).orientation == Orientation.landscape ?
                  controller.assetPathLandscape :
                  controller.assetPathPortrait,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MediaQuery.of(context).orientation == Orientation.landscape ?
                    MainAxisAlignment.end : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Automatically redirecting to Main Menu in ${controller.countdownTime}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}