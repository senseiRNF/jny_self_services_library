import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_function_collections/local_function_collections.dart';

class MethodChannelNative {
  BuildContext context;

  MethodChannelNative({required this.context});

  static const platform = MethodChannel('intidata.android/library_app');

  Future initMethod() async => await platform.invokeMethod(
    'init',
  ).catchError((e) {
    if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to init Method Channel\n\n${e.message}',
      );
    }
  });

  Future setDeviceToNative(String address) async => await platform.invokeMethod<bool>(
    'setConnectedBluetooth',
    {
      "address": address,
    },
  ).then((setResult) async {
    if(setResult != null) {
      await readRFID();
    }
  }).catchError((e) {
    if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to set device\n\n${e.message}',
      );
    }
  });

  Future removeDeviceFromNative() async => await platform.invokeMethod<bool>(
    'removeConnectedBluetooth',
  ).then((setResult) async {
    if(setResult != null) {
      await readRFID();
    }
  }).catchError((e) {
    if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to remove device\n\n${e.message}',
      );
    }
  });

  Future<String?> readRFID() async {
    String? result;

    await platform.invokeMethod<String>('readRFID').then((rfid) {
      result = rfid;
    }).catchError((e) {
      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Failed to scan RFID\n\n${e.message}',
        );
      }
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
      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Failed to write RFID\n\n${e.message}',
        );
      }
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
      if(context.mounted) {
        LocalDialogFunction.okDialog(
          context: context,
          contentText: 'Failed to set Power Level\n\n${e.message}',
        );
      }
    });

    return result;
  }

  Future startThreadRFID() async => await platform.invokeMethod(
    'startThread',
  ).catchError((e) {
    if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to scan RFID\n\n${e.message}',
      );
    }
  });

  Future stopThreadRFID() async => await platform.invokeMethod(
    'stopThread',
  ).catchError((e) {
    if(context.mounted) {
      LocalDialogFunction.okDialog(
        context: context,
        contentText: 'Failed to stop RFID Scan\n\n${e.message}',
      );
    }
  });
}