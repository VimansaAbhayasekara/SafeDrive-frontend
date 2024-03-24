import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of fireStore
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign in
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //after creating the user, create a new document
      _firebasefirestore.collection('user').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return userCredential;
    }
    // CATCH ANY ERROR
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//create new user
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign in
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //after creating the user, create a new document
      _firebasefirestore.collection('user').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    }
    // CATCH ANY ERROR
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
