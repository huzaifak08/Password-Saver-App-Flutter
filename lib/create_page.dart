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

  final formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Title',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 27),
              TextFormField(
                controller: emailController,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Email or Phone Number',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 27),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
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
                  }
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
      ),
    );
  }
}
