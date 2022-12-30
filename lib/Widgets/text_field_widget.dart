import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
);

class MyTextField extends StatelessWidget {
  String label;
  TextEditingController controller;
  MyTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFee7b64)),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFee7b64), width: 2)),
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
