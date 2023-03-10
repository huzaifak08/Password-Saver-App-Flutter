import 'package:flutter/material.dart';
import '../Widgets/widgets.dart';

class CreateReminderPage extends StatefulWidget {
  const CreateReminderPage({super.key});

  @override
  State<CreateReminderPage> createState() => _CreateReminderPageState();
}

class _CreateReminderPageState extends State<CreateReminderPage> {
  String savedTitle = '';
  String savedEmail = '';
  String savedPassword = '';
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

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
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Title',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    savedTitle = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 27),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Email or Phone Number',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    savedEmail = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 27),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                cursorColor: Theme.of(context).primaryColor,
                onChanged: (value) {
                  setState(() {
                    savedPassword = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Text Field can not be accepted';
                  } else
                    null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                // -------------------------------------------

                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //   setState(() {
                    //     isLoading = true;
                    //   });

                    //   DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                    //       .savaData(FirebaseAuth.instance.currentUser!.uid, {
                    //     'title': savedTitle,
                    //     'email': savedEmail,
                    //     'password': savedPassword,
                    //   }).whenComplete(() {
                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //     toastMessage('Data Saved Successfully');
                    //     nextScreenReplace(context, const HomePage());
                    //   });
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Save Data',
                        style: TextStyle(fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(120, 40)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
