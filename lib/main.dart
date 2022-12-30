import 'package:flutter/material.dart';
import 'package:password_saver/constants.dart';
import 'package:password_saver/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Constants().primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Constants().primaryColor),
        appBarTheme: AppBarTheme(backgroundColor: Constants().primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Constants().primaryColor)),
      ),
      home: const HomePage(),
    );
  }
}
