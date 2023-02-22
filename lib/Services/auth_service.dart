import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_saver/Helper/helper_function.dart';
import 'package:password_saver/Services/database_service.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  // Register the User:
  Future registerWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatbaseService(uid: user.uid)
            .saveUserInDatabase(fullName, email, password);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // Login User:
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return e.message;
    }
  }

  // Sign Out User:

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserNameSF('');
      await HelperFunction.saveUserEmailSF('');

      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
