import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    await _auth.signOut();
  }
}
