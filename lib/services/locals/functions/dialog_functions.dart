import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jny_self_services_library/services/locals/functions/route_functions.dart';

class OkDialog {
  BuildContext context;
  String? title;
  String content;
  Function? okPressed;
  bool? headIcon;

  OkDialog({
    required this.context,
    this.title,
    required this.content,
    this.okPressed,
    this.headIcon,
  });

  show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: headIcon != null ?
          headIcon! == true ?
          const Icon(
            Icons.mood,
            color: Colors.lightGreen,
          ) :
          const Icon(
            Icons.mood_bad,
            color: Colors.red,
          ) :
          const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          title: Text(
            title != null ? title! : headIcon != null ? headIcon! == true ? 'Success' : 'Failed' : 'Attention',
            style: TextStyle(
              color: title != null ? Colors.black : headIcon != null ? headIcon! == true ? Colors.lightGreen : Colors.red : Colors.black,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => CloseBack(context: context).go(),
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    ).then((_) {
      if(okPressed != null) {
        okPressed!();
      }
    });
  }
}

class OptionDialog {
  BuildContext context;
  String? title;
  String content;
  Function? yesPressed;
  Function? noPressed;

  OptionDialog({
    required this.context,
    this.title,
    required this.content,
    this.yesPressed,
    this.noPressed,
  });

  show() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
          title: Text(
            title ?? 'Attention',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => CloseBack(context: context, callbackData: false).go(),
              child: const Text(
                'No',
              ),
            ),
            TextButton(
              onPressed: () => CloseBack(context: context, callbackData: true).go(),
              child: const Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    ).then((dialogResult) {
      if(dialogResult != null) {
        if(dialogResult == true) {
          if(yesPressed != null) {
            yesPressed!();
          }
        } else {
          if(noPressed != null) {
            noPressed!();
          }
        }
      }
    });
  }
}

class LoadingDialog {
  BuildContext context;

  LoadingDialog({required this.context});

  show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          onPopInvoked: (pop) {
            if(pop) {
              return;
            }
          },
          child: const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Loading data from server, please wait...',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ErrorHandler {
  BuildContext context;
  DioException dioExc;

  ErrorHandler({
    required this.context,
    required this.dioExc,
  });

  void show() {
    int? errCode;
    String? serverErrMessage;
    String? errMessage;

    if(dioExc.response != null) {
      errCode = dioExc.response!.statusCode;

      if(dioExc.response!.data != null) {
        if(dioExc.response!.data!['message'] != null) {
          serverErrMessage = dioExc.response!.data!['message'];
        }
      }
    }

    if(serverErrMessage != null) {
      errMessage = serverErrMessage;
    } else {
      switch(errCode) {
        case 400:
          errMessage = 'Bad request. Please try again!';
          break;
        case 401:
          errMessage = 'Unauthorized action. Please try again!';
          break;
        case 404:
          errMessage = 'Request not found. For more information, please contact administrator!';
          break;
        case 422:
          errMessage = 'Invalid input request. Please check all submitted data and try again!';
          break;
        case 500:
          errMessage = 'Internal server error. For more information, please contact administrator!';
          break;
        case 599:
          errMessage = "Unknown status. Unable to access this menu because it's under maintenance. For more information, please contact administrator!";
          break;
        default:
          errMessage = 'Connection failed. Please check your internet connection';
          break;
      }
    }

    OkDialog(
      context: context,
      content: errMessage,
      headIcon: false,
    ).show();
  }
}