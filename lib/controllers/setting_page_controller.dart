import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_setup_page_controller.dart';
import 'package:jny_self_services_library/controllers/bluetooth_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/check_book_alarm_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/lock_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/monitor_setup_page_controller.dart';
import 'package:jny_self_services_library/controllers/splash_page_controller.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
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

  changePowerLevelReader() async => await SharedPrefsFunctions.readData('powerLevel').then((currentPower) {
    double powerLevel = 0.0;

    if(currentPower != null) {
      powerLevel = double.parse(currentPower);
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext stateContext, stateSetter) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: powerLevel,
                          min: 0.0,
                          max: 30.0,
                          divisions: 6,
                          onChanged: (newPowerLevel) {
                            stateSetter(() {
                              powerLevel = newPowerLevel;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          powerLevel.toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () => CloseBack(context: context, callbackData: powerLevel.toInt()).go(),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Save Power Level",
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((dialogResult) async {
      if(dialogResult != null) {
        await MethodChannelNative(context: context).setPowerLevel(dialogResult).then((setResult) async {
          if(setResult == true) {
            await SharedPrefsFunctions.writeData('powerLevel', dialogResult.toString());
          }
        });
      }
    });
  });

  setupMonitorPairingID() => MoveTo(
    context: context,
    target: const MonitorSetupPage(),
  ).go();

  setupServerGateURL() => MoveTo(
    context: context,
    target: const AlarmGateSetupPage(),
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