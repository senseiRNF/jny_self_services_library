import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/static_variables.dart';
import 'package:jny_self_services_library/view_pages/lock_setting_view_page.dart';
import 'package:local_function_collections/local_function_collections.dart';

class LockSettingPage extends StatefulWidget {
  final bool? updatePIN;

  const LockSettingPage({
    super.key,
    this.updatePIN,
  });

  @override
  State<LockSettingPage> createState() => LockSettingPageController();
}

class LockSettingPageController extends State<LockSettingPage> {
  TextEditingController pinController = TextEditingController();

  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confPinController = TextEditingController();

  bool showOldPIN = true;
  bool showNewPIN = false;
  bool showConfPIN = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => checkPIN());
  }

  void checkPIN() async {
    String? pin = await LocalSecureStorage.readKey(
      key: StaticVariables.pinKey,
    );

    if(pin == null) {
      await LocalSecureStorage.writeKey(
        key: StaticVariables.pinKey,
        data: "000000",
      );
    }
  }

  void inputPIN(int inputtedNumber) async {
    if(mounted && pinController.text.isEmpty) {
      setState(() {
        pinController.text = inputtedNumber.toString();
      });
    } else if(mounted && pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + inputtedNumber.toString();
      });

      if(pinController.text.length == 6) {
        String? pin = await LocalSecureStorage.readKey(
          key: StaticVariables.pinKey,
        );

        if(mounted && pin != null && pinController.text == pin) {
          LocalRouteNavigator.closeBack(
            context: context,
            callbackResult: true,
          );
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Wrong combination of lock PIN',
            onClose: () {
              if(mounted) {
                setState(() {
                  pinController.text = '';
                });
              }
            },
          );
        }
      }
    }
  }

  void erasePIN() {
    if(mounted && pinController.text.isNotEmpty) {
      setState(() {
        pinController.text = pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }

  void inputOldPIN(int inputtedNumber) async {
    if(mounted && oldPinController.text.isEmpty) {
      setState(() {
        oldPinController.text = inputtedNumber.toString();
      });
    } else if(mounted && oldPinController.text.length < 6) {
      setState(() {
        oldPinController.text = oldPinController.text + inputtedNumber.toString();
      });

      if(oldPinController.text.length == 6) {
        String? pin = await LocalSecureStorage.readKey(
          key: StaticVariables.pinKey,
        );

        if(mounted && pin != null && oldPinController.text == pin) {
          setState(() {
            showOldPIN = false;
            showNewPIN = true;
          });
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: 'Wrong combination of lock PIN',
            onClose: () => setState(() {
              oldPinController.text = '';
            }),
          );
        }
      }
    }
  }

  void eraseOldPIN() {
    if(mounted && oldPinController.text.isNotEmpty) {
      setState(() {
        oldPinController.text = oldPinController.text.substring(0, oldPinController.text.length - 1);
      });
    }
  }

  void inputNewPIN(int inputtedNumber) async {
    if(mounted && newPinController.text.isEmpty) {
      setState(() {
        newPinController.text = inputtedNumber.toString();
      });
    } else if(mounted && newPinController.text.length < 6) {
      setState(() {
        newPinController.text = newPinController.text + inputtedNumber.toString();
      });

      if(mounted && newPinController.text.length == 6) {
        setState(() {
          showNewPIN = false;
          showConfPIN = true;
        });
      }
    }
  }

  void eraseNewPIN() {
    if(mounted && newPinController.text.isNotEmpty) {
      setState(() {
        newPinController.text = newPinController.text.substring(0, newPinController.text.length - 1);
      });
    }
  }

  void inputConfPIN(int inputtedNumber) async {
    if(mounted && confPinController.text.isEmpty) {
      setState(() {
        confPinController.text = inputtedNumber.toString();
      });
    } else if(mounted && confPinController.text.length < 6) {
      setState(() {
        confPinController.text = confPinController.text + inputtedNumber.toString();
      });

      if(confPinController.text.length == 6) {
        if(confPinController.text == newPinController.text) {
          bool writeResult = await LocalSecureStorage.writeKey(
            key: StaticVariables.pinKey,
            data: confPinController.text,
          );

          if(mounted && writeResult) {
            LocalDialogFunction.okDialog(
              context: context,
              contentText: "Success change lock PIN",
              onClose: () => LocalRouteNavigator.closeBack(
                context: context,
              ),
            );
          } else if(mounted) {
            LocalDialogFunction.okDialog(
              context: context,
              contentText: "Failed to change lock PIN, wrong combination of lock PIN",
              onClose: () {
                if(mounted) {
                  setState(() {
                    confPinController.text = '';
                  });
                }
              }
            );
          }
        } else if(mounted) {
          LocalDialogFunction.okDialog(
            context: context,
            contentText: "Failed to change lock PIN, wrong combination of lock PIN",
            onClose: () {
              if(mounted) {
                setState(() {
                  confPinController.text = '';
                });
              }
            },
          );
        }
      }
    }
  }

  void eraseConfPIN() {
    if(mounted && confPinController.text.isNotEmpty) {
      setState(() {
        confPinController.text = confPinController.text.substring(0, confPinController.text.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LockSettingViewPage(controller: this);
  }
}