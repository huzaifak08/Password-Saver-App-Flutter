import 'package:flutter/material.dart';
import 'package:password_saver/Pages/Auth/login_page.dart';
import 'package:password_saver/Services/auth_service.dart';
import 'package:password_saver/Widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          authService.signOut().then((value) {
            nextScreenReplace(context, const LoginPage());
            toastMessage('Successflly Log out');
          });
        },
        child: Text('Sign Out'),
      )),
    );
  }
}
