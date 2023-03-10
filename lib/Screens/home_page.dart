import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Saved Data'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      // body: dataList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextScreen(context, const CreateReminderPage());
        },
        child: const Icon(Icons.add),
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
