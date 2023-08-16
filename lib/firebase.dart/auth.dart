import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth fire = FirebaseAuth.instance;
  static Auth auth = Auth();
  UserCredential? user1;
   
  SignOut() async{
   await fire.signOut();
  }

  SignIn({required String password, required String email}) async {
    //   FirebaseAuth fire = await FirebaseAuth.instance;
    try {
      UserCredential user = await fire.signInWithEmailAndPassword(
          email: email, password: password);
      user1 = user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: ' the Email is wrong');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'the password is worng');
      }

      // print(e);
    }
  }

  signUp({required String password, required String email}) async {
    // FirebaseAuth fire = await FirebaseAuth.instance;
    try {
      await fire.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
