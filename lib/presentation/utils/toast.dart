import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastMsg {
  void toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.orange,
        fontSize: 16.0,
        gravity: ToastGravity.TOP
    );
  }
}
