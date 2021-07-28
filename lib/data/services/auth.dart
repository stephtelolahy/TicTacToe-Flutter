import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart' as model;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  observeAuthState(void onChange(String? userId)) {
    _auth.authStateChanges().listen((User? user) {
      onChange(user?.uid);
    });
  }

  String userName() {
    return _auth.currentUser?.displayName ?? '';
  }

  String userId() {
    return _auth.currentUser!.uid;
  }

  String photoURL() {
    return _auth.currentUser!.photoURL ?? '';
  }

  Future<model.User> signInWithGoogle() async {
    UserCredential userCredential;
    if (kIsWeb) {
      // Create a Google auth provider
      var googleProvider = GoogleAuthProvider();
      // Once signed in, return the UserCredential
      userCredential = await _auth.signInWithPopup(googleProvider);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: []).signIn();
      if (googleUser == null) {
        throw ('Missing google user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
    }

    final user = userCredential.user;
    print('signInWithGoogle: ${user!.displayName}');

    return model.User(user.uid, user.displayName ?? user.uid, user.photoURL ?? '', 0);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
