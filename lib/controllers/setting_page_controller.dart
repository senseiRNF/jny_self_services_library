import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/bluetooth_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/check_book_alarm_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/lock_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/splash_page_controller.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/view_pages/setting_view_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SettingPageController();
}

class SettingPageController extends State<SettingPage> {

  openBluetoothSettings() => MoveTo(
    context: context,
    target: const BluetoothSettingPage(),
  ).go();

  openCheckBookAlarmSettings() => MoveTo(
    context: context,
    target: const CheckBookAlarmSettingPage(),
  ).go();

  changeLockPIN() => MoveTo(
    context: context,
    target: const LockSettingPage(
      updatePIN: true,
    ),
  ).go();

  signOut() => OptionDialog(
    context: context,
    content: 'Sign out from this account, are you sure?',
    yesPressed: () async {
      await SharedPrefsFunctions.removeData('bluetooth').then((removeBTResult) async {
        if(removeBTResult == true) {
          await SharedPrefsFunctions.removeData('account').then((removeAccResult) {
            if(removeAccResult == true) {
              RedirectTo(
                context: context,
                target: const SplashPage(),
              ).go();
            }
          });
        }
      });
    },
  ).show();

  @override
  Widget build(BuildContext context) {
    return SettingViewPage(controller: this);
  }
}