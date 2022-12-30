import 'package:flutter/material.dart';
import 'package:password_saver/Widgets/nextscreen_widgets.dart';
import 'package:password_saver/Widgets/text_field_widget.dart';
import 'package:password_saver/database_handler.dart';
import 'package:password_saver/home_page.dart';
import 'package:password_saver/notes_model.dart';

class CreateReminderPage extends StatefulWidget {
  CreateReminderPage({super.key});

  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  final titleController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  DBHelper? dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
        child: Column(
          children: [
            MyTextField(
              label: 'Enter Title',
              controller: titleController,
            ),
            const SizedBox(height: 27),
            MyTextField(
              label: 'Enter Email or Phone Number',
              controller: emailController,
            ),
            const SizedBox(height: 27),
            MyTextField(
              label: 'Enter Password',
              controller: passwordController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                dbHelper!
                    .insert(NotesModel(
                        title: titleController.text.toUpperCase(),
                        email: emailController.text,
                        password: passwordController.text))
                    .then((value) {
                  debugPrint('Data Added');
                  nextScreenReplace(context, HomePage());
                }).onError((error, stackTrace) {
                  debugPrint(error.toString());
                });
              },
              child: Text(
                'Save Data',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(fixedSize: Size(120, 40)),
            )
          ],
        ),
      ),
    );
  }
}
