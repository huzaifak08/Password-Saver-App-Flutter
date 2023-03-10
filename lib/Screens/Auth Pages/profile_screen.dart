import 'package:flutter/material.dart';
import 'package:password_saver/Screens/Auth%20Pages/welcome_screen.dart';
import 'package:password_saver/Screens/home_page.dart';
import 'package:password_saver/Widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../Provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text("User Profile"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                ap.userSignOut().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WelcomeScreen(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.purple,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ListTile(
                onTap: () {
                  nextScreenReplace(context, const HomePage());
                },
                title: const Text(
                  'Home Page',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const ListTile(
                selected: true,
                selectedTileColor: Colors.white,
                title: Text(
                  'Profile Page',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text(ap.userModel.name),
            Text(ap.userModel.phoneNumber),
            Text(ap.userModel.email),
            Text(ap.userModel.bio),
          ],
        )),
      ),
    );
  }
}
