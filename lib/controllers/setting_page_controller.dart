import 'package:flutter/material.dart';
import 'package:jny_self_services_library/controllers/alarm_gate_setup_page_controller.dart';
import 'package:jny_self_services_library/controllers/bluetooth_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/check_book_status_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/lock_setting_page_controller.dart';
import 'package:jny_self_services_library/controllers/monitor_setup_page_controller.dart';
import 'package:jny_self_services_library/controllers/splash_page_controller.dart';
import 'package:jny_self_services_library/controllers/health_check_page_controller.dart';
import 'package:jny_self_services_library/services/locals/bridging_channel/method_channel_native.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/view_pages/setting_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => SettingPageController();
}

class SettingPageController extends State<SettingPage> {
  
  @override
  void initState() {
    super.initState();
  }

  void openBluetoothSettings() => LocalRouteNavigator.moveTo(
    context: context,
    target: const BluetoothSettingPage(),
  );

  void openCheckBookStatusSettings() => LocalRouteNavigator.moveTo(
    context: context,
    target: const CheckBookStatusSettingPage(),
  );

  void changeLockPIN() => LocalRouteNavigator.moveTo(
    context: context,
    target: const LockSettingPage(
      updatePIN: true,
    ),
  );

  void changePowerLevelReader() async {
    String? currentPowerLevel = await LocalSecureStorage.readKey(
      key: StaticVariables.powerLevelKey,
    );

    double powerLevel = double.parse(currentPowerLevel ?? "0.0");

    if(!mounted) return;

    int? dialogResult = await showDialog<int?>(
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
                    onPressed: () => LocalRouteNavigator.closeBack(
                      context: context,
                      callbackResult: powerLevel.toInt(),
                    ),
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
    );

    if(!mounted) return;

    if(dialogResult != null) {
      bool setResult = await MethodChannelNative(context: context)
          .setPowerLevel(dialogResult);

      if(setResult == true) {
        await LocalSecureStorage.writeKey(
          key: StaticVariables.powerLevelKey,
          data: dialogResult.toString(),
        );
      }
    }
  }

  void setupMonitorPairingID() => LocalRouteNavigator.moveTo(
    context: context,
    target: const MonitorSetupPage(),
  );

  void setupServerGateURL() => LocalRouteNavigator.moveTo(
    context: context,
    target: const AlarmGateSetupPage(),
  );

  void openHealthCheck() => LocalRouteNavigator.moveTo(
    context: context,
    target: const HealthCheckPage(),
  );

  void signOut() => LocalDialogFunction.optionDialog(
    context: context,
    contentText: 'Sign out from this account, are you sure?',
    onAccept: () async {
      bool removeBTResult = await LocalSecureStorage.deleteKey(
        key: StaticVariables.bluetoothKey,
      );

      bool removeAccountResult = await LocalSecureStorage.deleteKey(
        key: StaticVariables.accountKey,
      );

      if(mounted && removeBTResult == true && removeAccountResult == true) {
        LocalRouteNavigator.redirectTo(
          context: context,
          target: const SplashPage(),
        );
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return SettingViewPage(controller: this);
  }
}