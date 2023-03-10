import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Screens/Auth%20Pages/profile_screen.dart';
import 'package:password_saver/Widgets/data_widget.dart';
import 'package:password_saver/Widgets/widgets.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          // elevation: 0,
          title: Text('Saved Data'),
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
        // body: dataList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            nextScreen(context, const CreateReminderPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  dataList() {
    return StreamBuilder<QuerySnapshot>(
      stream: data,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs != null) {
            if (snapshot.data!.docs.length != 0) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      DataTile(
                        title: snapshot.data!.docs[index]['title'],
                        email: snapshot.data!.docs[index]['email'],
                        password: snapshot.data!.docs[index]['password'],
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
