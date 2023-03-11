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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 217, 117, 235),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text("User Profile"),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.purple,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.white70,
              ),
              // CircleAvatar(
              //   backgroundColor: Colors.purple,
              //   backgroundImage: NetworkImage(
              //     ap.userModel.profilePic,
              //   ),
              //   radius: 80,
              // ),
              ListTile(
                onTap: () {
                  nextScreenReplace(context, const HomePage());
                },
                title: const Text(
                  'Home',
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
                  'Profile',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                onTap: () {
                  ap.userSignOut().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        ),
                      );
                },
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              backgroundColor: Colors.purple,
              backgroundImage: NetworkImage(ap.userModel.profilePic),
              radius: 80,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50)),
                    color: Colors.purple),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      title: Text(
                        ap.userModel.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      title: Text(
                        ap.userModel.email,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.phone_android_outlined,
                        color: Colors.white,
                        size: 35,
                      ),
                      title: Text(
                        ap.userModel.phoneNumber,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 217, 117, 235),
                          borderRadius: BorderRadius.circular(23)),
                      child: Text(ap.userModel.bio,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        // body: Center(
        //     child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     CircleAvatar(
        //       backgroundColor: Colors.purple,
        //       backgroundImage: NetworkImage(ap.userModel.profilePic),
        //       radius: 50,
        //     ),
        //     const SizedBox(height: 20),
        //     Text(ap.userModel.name),
        //     Text(ap.userModel.phoneNumber),
        //     Text(ap.userModel.email),
        //     Text(ap.userModel.bio),
        //   ],
        // )),
      ),
    );
  }
}
