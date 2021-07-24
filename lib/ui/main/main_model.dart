import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum UserState { unknown, signedIn, signedOut }

class MainModel extends ChangeNotifier {
  UserState _userState = UserState.unknown;

  // states

  UserState get userState => _userState;

  // actions

  void initialize() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _userState = user != null ? UserState.signedIn : UserState.signedOut;
      print("AuthStateChanges User: ${user?.displayName}");
      notifyListeners();
    });
  }
}
