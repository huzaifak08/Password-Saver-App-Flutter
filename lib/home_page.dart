import 'package:flutter/material.dart';
import 'package:password_saver/Widgets/nextscreen_widgets.dart';
import 'package:password_saver/create_page.dart';
import 'package:password_saver/notes_model.dart';

import 'database_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper? dbHelper;

  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Saved Data',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: FutureBuilder(
              future: notesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {}
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    snapshot.data![index].title,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      // color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 120),
                                      Text(snapshot.data![index].email)
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const SizedBox(width: 20),
                                      const Text(
                                        'Password',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 95),
                                      Text(snapshot.data![index].password)
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Delete from database:
                                      dbHelper!
                                          .delete(snapshot.data![index].id!);

                                      // Get Data again after deletion of certain data:
                                      notesList = dbHelper!.getNotesList();

                                      // Remove the index from the appeared screen also:
                                      snapshot.data!
                                          .remove(snapshot.data![index]);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Data Deleted Successfully')));

                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete),
                                    label: const Text('Delete'),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ));
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextScreen(context, CreateReminderPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
