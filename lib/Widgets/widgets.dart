import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
);

nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Color(0xFFee7b64),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
