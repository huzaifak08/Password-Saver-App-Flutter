import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Helper/helper_function.dart';
import 'package:password_saver/Pages/create_page.dart';
import 'package:password_saver/constants.dart';
import 'package:password_saver/Pages/home_page.dart';

import 'Pages/Auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false;

  @override
  void initState() {
    getUserLoggedInStatus();
    super.initState();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Constants().primaryColor),
        appBarTheme: AppBarTheme(backgroundColor: Constants().primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Constants().primaryColor)),
      ),
      home: isSignedIn ? const HomePage() : const LoginPage(),
      // home: CreateReminderPage(),
    );
  }
}
