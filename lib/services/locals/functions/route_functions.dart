import 'package:flutter/material.dart';

class MoveTo {
  BuildContext context;
  Widget target;
  Function? callback;

  MoveTo({
    required this.context,
    required this.target,
    this.callback,
  });

  go() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext targetContext) => target),
    ).then((callbackData) {
      if(callback != null) {
        callback!(callbackData);
      }
    });
  }
}

class ReplaceTo {
  BuildContext context;
  Widget target;

  ReplaceTo({
    required this.context,
    required this.target,
  });

  go() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext targetContext) => target),
    );
  }
}

class RedirectTo {
  BuildContext context;
  Widget target;

  RedirectTo({
    required this.context,
    required this.target,
  });

  go() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext targetContext) => target), (route) => false,
    );
  }
}

class CloseBack {
  BuildContext context;
  dynamic callbackData;

  CloseBack({
    required this.context,
    this.callbackData,
  });

  go() {
    Navigator.of(context).pop(callbackData);
  }
}