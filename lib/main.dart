import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Provider/auth_provider.dart';
import 'package:password_saver/Provider/database_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.purple),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.purple),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple)),
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
