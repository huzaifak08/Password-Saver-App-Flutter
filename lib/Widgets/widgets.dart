import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

const textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple, width: 2)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple, width: 2)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple, width: 2)),
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
    backgroundColor: Colors.purple,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    toastMessage(e.toString());
  }

  return image;
}
