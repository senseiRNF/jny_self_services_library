import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';
import 'package:jny_self_services_library/services/locals/functions/shared_prefs_functions.dart';
import 'package:jny_self_services_library/view_pages/lock_setting_view_page.dart';

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

    checkPIN();
  }

  checkPIN() async {
    await SharedPrefsFunctions.readData('pin').then((pin) async {
      if(pin == null) {
        await SharedPrefsFunctions.writeData('pin', '000000');
      }
    });
  }

  inputPIN(int inputtedNumber) async {
    if(pinController.text.isEmpty) {
      setState(() {
        pinController.text = inputtedNumber.toString();
      });
    } else if(pinController.text.length < 6) {
      setState(() {
        pinController.text = pinController.text + inputtedNumber.toString();
      });

      if(pinController.text.length == 6) {
        await SharedPrefsFunctions.readData('pin').then((pin) {
          if(pin != null && pinController.text == pin) {
            CloseBack(
              context: context,
              callbackData: true,
            ).go();
          } else {
            OkDialog(
              context: context,
              content: 'Wrong combination of lock PIN',
              headIcon: false,
              okPressed: () => setState(() {
                pinController.text = '';
              }),
            ).show();
          }
        });
      }
    }
  }

  erasePIN() {
    if(pinController.text.isNotEmpty) {
      setState(() {
        pinController.text = pinController.text.substring(0, pinController.text.length - 1);
      });
    }
  }

  inputOldPIN(int inputtedNumber) async {
    if(oldPinController.text.isEmpty) {
      setState(() {
        oldPinController.text = inputtedNumber.toString();
      });
    } else if(oldPinController.text.length < 6) {
      setState(() {
        oldPinController.text = oldPinController.text + inputtedNumber.toString();
      });

      if(oldPinController.text.length == 6) {
        await SharedPrefsFunctions.readData('pin').then((pin) {
          if(pin != null && oldPinController.text == pin) {
            setState(() {
              showOldPIN = false;
              showNewPIN = true;
            });
          } else {
            OkDialog(
              context: context,
              content: 'Wrong combination of lock PIN',
              headIcon: false,
              okPressed: () => setState(() {
                oldPinController.text = '';
              }),
            ).show();
          }
        });
      }
    }
  }

  eraseOldPIN() {
    if(oldPinController.text.isNotEmpty) {
      setState(() {
        oldPinController.text = oldPinController.text.substring(0, oldPinController.text.length - 1);
      });
    }
  }

  inputNewPIN(int inputtedNumber) async {
    if(newPinController.text.isEmpty) {
      setState(() {
        newPinController.text = inputtedNumber.toString();
      });
    } else if(newPinController.text.length < 6) {
      setState(() {
        newPinController.text = newPinController.text + inputtedNumber.toString();
      });

      if(newPinController.text.length == 6) {
        setState(() {
          showNewPIN = false;
          showConfPIN = true;
        });
      }
    }
  }

  eraseNewPIN() {
    if(newPinController.text.isNotEmpty) {
      setState(() {
        newPinController.text = newPinController.text.substring(0, newPinController.text.length - 1);
      });
    }
  }

  inputConfPIN(int inputtedNumber) async {
    if(confPinController.text.isEmpty) {
      setState(() {
        confPinController.text = inputtedNumber.toString();
      });
    } else if(confPinController.text.length < 6) {
      setState(() {
        confPinController.text = confPinController.text + inputtedNumber.toString();
      });

      if(confPinController.text.length == 6) {
        if(confPinController.text == newPinController.text) {
          await SharedPrefsFunctions.writeData('pin', confPinController.text).then((writeResult) {
            if(writeResult == true) {
              OkDialog(
                context: context,
                content: 'Success change lock PIN',
                headIcon: true,
                okPressed: () => CloseBack(context: context, callbackData: true).go(),
              ).show();
            }
          });
        } else {
          OkDialog(
            context: context,
            content: 'Failed to change lock PIN, wrong combination of lock PIN',
            headIcon: false,
            okPressed: () => setState(() {
              confPinController.text = '';
            }),
          ).show();
        }
      }
    }
  }

  eraseConfPIN() {
    if(confPinController.text.isNotEmpty) {
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