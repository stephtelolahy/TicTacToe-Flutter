import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/services/database.dart';
import '../../locator.dart';

class LoginModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _databaseService = locator<DatabaseService>();

  // actions

  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        // Create a Googlew auth provider
        var googleProvider = GoogleAuthProvider();
        // Once signed in, return the UserCredential
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser =
            await GoogleSignIn(scopes: []).signIn();
        if (googleUser == null) {
          return;
        }

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

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

      // Add user in firebase Database
      await _databaseService.createUser(
          user.uid, user.displayName, user.photoURL);
    } catch (e) {
      print(e);
    }
  }
}
