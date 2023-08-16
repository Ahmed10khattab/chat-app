import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStore {
  static var firestore = FireStore();
  FirebaseFirestore store = FirebaseFirestore.instance;
  GetMSG() async {
    Stream<QuerySnapshot> data = await store.collection('Message').snapshots();
  }

  delete(documentId) {
    store.collection('Message').doc(documentId).delete();
  }

  // Add() async {
  //   await store
  //       .collection('MSG')
  //       .doc(Random().nextDouble().toString())
  //       .set({'msg': 'hhhhhh'});
  // }

}

  