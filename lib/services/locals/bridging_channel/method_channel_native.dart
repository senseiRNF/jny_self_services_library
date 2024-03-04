import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';

class MethodChannelNative {
  BuildContext context;

  MethodChannelNative({required this.context});

  static const platform = MethodChannel('intidata.android/library_app');

  Future initMethod() async {
    try {
      await platform.invokeMethod('init');
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to init Method Channel\n\n${e.message}',
        headIcon: false,
      ).show();
    }
  }

  Future setDeviceToNative(String address) async {
    try {
      await platform.invokeMethod<bool>(
        'setConnectedBluetooth',
        {
          "address": address,
        },
      ).then((setResult) async {
        if(setResult != null) {
          await readRFID();
        }
      });
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to set device\n\n${e.message}',
        headIcon: false,
      ).show();
    }
  }

  Future removeDeviceFromNative() async {
    try {
      await platform.invokeMethod<bool>(
        'removeConnectedBluetooth',
      ).then((setResult) async {
        if(setResult != null) {
          await readRFID();
        }
      });
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to remove device\n\n${e.message}',
        headIcon: false,
      ).show();
    }
  }

  Future<String?> readRFID() async {
    String? result;

    try {
      await platform.invokeMethod<String>('readRFID').then((rfid) {
        result = rfid;
      });
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to scan RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    }

    return result;
  }

  Future<bool> writeRFID(String newRFID) async {
    bool result = false;

    try {
      await platform.invokeMethod<bool>(
        'writeRFID',
        {
          "newRFID" : newRFID,
        },
      ).then((writeResult) {
        if(writeResult != null) {
          result = writeResult;
        }
      });
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to write RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    }

    return result;
  }

  Future startThreadRFID() async {
    try {
      await platform.invokeMethod('startThread');
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to scan RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    }
  }

  Future stopThreadRFID() async {
    try {
      await platform.invokeMethod('stopThread');
    } on PlatformException catch(e) {
      OkDialog(
        context: context,
        content: 'Failed to stop RFID Scan\n\n${e.message}',
        headIcon: false,
      ).show();
    }
  }
}