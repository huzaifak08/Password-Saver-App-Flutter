import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final String title;
  final String email;
  final String password;
  const DataTile(
      {super.key,
      required this.title,
      required this.email,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          // height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Email :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Text(email, style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Password :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Text(password, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
