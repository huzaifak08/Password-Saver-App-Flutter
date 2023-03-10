import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Provider/database_provider.dart';
import 'package:password_saver/Screens/Auth%20Pages/profile_screen.dart';
import 'package:password_saver/Widgets/data_widget.dart';
import 'package:password_saver/Widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot>? data;

  @override
  void initState() {
    super.initState();
  }

  // String Manipulation:

  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context);

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
              const ListTile(
                selected: true,
                selectedTileColor: Colors.white,
                title: Text(
                  'Home Page',
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
                  'Profile Page',
                  style: TextStyle(color: Colors.white),
                ),
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              )
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
                      return Column(
                        children: [
                          DataTile(
                            title: myData['title'],
                            email: myData['email'],
                            password: myData['password'],
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
}
