import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginModel extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  void initialize() async {
    await Firebase.initializeApp();

    _auth.authStateChanges().listen((User? user) {
      _signedIn = user != null;
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
      }

      final user = userCredential.user;
      print('Sign In ${user!.uid} with Google');
    } catch (e) {
      print(e);
    }
  }
}
