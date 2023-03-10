import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Provider/auth_provider.dart';
import 'package:password_saver/constants.dart';
import 'package:provider/provider.dart';
import 'Screens/Auth Pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
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
        // home: isSignedIn ? const HomePage() : const LoginPage(),
        home: const WelcomeScreen(),
      ),
    );
  }
}
