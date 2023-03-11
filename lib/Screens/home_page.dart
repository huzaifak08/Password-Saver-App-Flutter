import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Provider/auth_provider.dart';
import 'package:password_saver/Provider/database_provider.dart';
import 'package:password_saver/Screens/Auth%20Pages/profile_screen.dart';
import 'package:password_saver/Widgets/data_widget.dart';
import 'package:password_saver/Widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'Auth Pages/welcome_screen.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dataId = '';

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context, listen: false);
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          // elevation: 0,
          title: const Text('Saved Data'),
          centerTitle: true,
        ),
        drawer: Drawer(
          backgroundColor: Colors.purple,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.white70,
              ),
              const ListTile(
                selected: true,
                selectedTileColor: Colors.white,
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                onTap: () {
                  nextScreenReplace(context, const ProfileScreen());
                },
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
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
        body: StreamBuilder<QuerySnapshot>(
          stream: database.getSavedData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dataDocs = snapshot.data!.docs;

              if (snapshot.data!.docs != null) {
                if (snapshot.data!.docs.length != 0) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final myData =
                          dataDocs[index].data()! as Map<String, dynamic>;
                      dataId = myData['dataId'];
                      return Column(
                        children: [
                          DataTile(
                            title: myData['title'],
                            email: myData['email'],
                            password: myData['password'],
                            onPressed: () {
                              popUpDialogue(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return noGroupWidget();
                }
              } else {
                return noGroupWidget();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nextScreen(context, const CreateReminderPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  noGroupWidget() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // popUpDialog(context);
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
                size: 75,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You haven't saved any of the data yet. Save the data to view here.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  popUpDialogue(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context, listen: false);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  database.deleteSavedData(dataId).then((value) {
                    Navigator.pop(context);

                    toastMessage('Deletion Complete');
                  }).onError((error, stackTrace) {
                    toastMessage(error.toString());

                    Navigator.pop(context);
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.purple,
                ))
          ],
        );
      },
    );
  }
}
