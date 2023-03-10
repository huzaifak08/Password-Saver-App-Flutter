import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  String? _uid;
  String get uid => _uid!;

  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('data');

  Future createProductData(
      String title, String email, String password, String userId) async {
    DocumentReference dataDocumentReference = await dataCollection.add({
      "title": title,
      "email": email,
      "password": password,
      "userId": userId,
      "admin": "${userId}_$title",
      "dataId":
          "", // This will be generate after the execution of this method so we have to update this after this method
    });

    // Update the members:
    await dataDocumentReference.update({
      "dataId": dataDocumentReference.id,
    });

    notifyListeners();
  }

  // Get Data:
  Stream<QuerySnapshot> getSavedData(String userId) {
    return dataCollection.where('userId', isEqualTo: userId).snapshots();
  }
}
