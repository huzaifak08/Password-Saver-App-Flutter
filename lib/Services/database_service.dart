import 'package:cloud_firestore/cloud_firestore.dart';

class DatbaseService {
  String? uid;

  DatbaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('data');

  // Save 'users' in Database:

  Future saveUserInDatabase(
      String fullName, String email, String password) async {
    return await usersCollection.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'password': password,
      'data': [],
    });
  }
}
