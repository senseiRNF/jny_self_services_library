import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jny_self_services_library/services/locals/functions/dialog_functions.dart';

class MethodChannelNative {
  BuildContext context;

  MethodChannelNative({required this.context});

  static const platform = MethodChannel('intidata.android/library_app');

  Future initMethod() async {
    await platform.invokeMethod('init').catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to init Method Channel\n\n${e.message}',
        headIcon: false,
      ).show();
    });
  }

  Future setDeviceToNative(String address) async {
    await platform.invokeMethod<bool>(
      'setConnectedBluetooth',
      {
        "address": address,
      },
    ).then((setResult) async {
      if(setResult != null) {
        await readRFID();
      }
    }).catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to set device\n\n${e.message}',
        headIcon: false,
      ).show();
    });
  }

  Future removeDeviceFromNative() async {
    await platform.invokeMethod<bool>(
      'removeConnectedBluetooth',
    ).then((setResult) async {
      if(setResult != null) {
        await readRFID();
      }
    }).catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to remove device\n\n${e.message}',
        headIcon: false,
      ).show();
    });
  }

  Future<String?> readRFID() async {
    String? result;

    await platform.invokeMethod<String>('readRFID').then((rfid) {
      result = rfid;
    }).catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to scan RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    });

    return result;
  }

  Future<bool> writeRFID(String newRFID) async {
    bool result = false;

    await platform.invokeMethod<bool>(
      'writeRFID',
      {
        "newRFID" : newRFID,
      },
    ).then((writeResult) {
      if(writeResult != null) {
        result = writeResult;
      }
    }).catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to write RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    });

    return result;
  }

  Future<bool> setPowerLevel(int powerLevel) async {
    bool result = false;

    await platform.invokeMethod<bool>(
      'setPowerLevel',
      {
        "powerLevel" : powerLevel,
      },
    ).then((writeResult) {
      if(writeResult != null) {
        result = writeResult;
      }
    }).catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to set Power Level\n\n${e.message}',
        headIcon: false,
      ).show();
    });

    return result;
  }

  Future startThreadRFID() async {
    await platform.invokeMethod('startThread').catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to scan RFID\n\n${e.message}',
        headIcon: false,
      ).show();
    });
  }

  Future stopThreadRFID() async {
    await platform.invokeMethod('stopThread').catchError((e) {
      OkDialog(
        context: context,
        content: 'Failed to stop RFID Scan\n\n${e.message}',
        headIcon: false,
      ).show();
    });
  }
}