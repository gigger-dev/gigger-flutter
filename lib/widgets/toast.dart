import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as t;

export 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static Future<bool?> show(
    String msg, {
    bool isLong = true,
    Color? backgroundColor,
    t.ToastGravity? gravity,
  }) {
    return t.Fluttertoast.showToast(
      msg: msg,
      gravity: gravity,
      backgroundColor: backgroundColor,
      toastLength: isLong ? t.Toast.LENGTH_LONG : t.Toast.LENGTH_SHORT,
    );
  }

  static Future<bool?> success(String msg) {
    return show(msg, backgroundColor: Colors.green);
  }

  static Future<bool?> warning(String msg) {
    return show(msg, backgroundColor: Colors.orange);
  }

  static Future<bool?> error(String msg, {t.ToastGravity? gravity}) {
    return show(msg, backgroundColor: Colors.red, gravity: gravity);
  }
}
