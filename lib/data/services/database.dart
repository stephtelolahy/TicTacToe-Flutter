import 'package:firebase_database/firebase_database.dart';

import '../models/user.dart';

class DatabaseService {
  late DatabaseReference _usersRef;

  void initialize() {
    _usersRef = FirebaseDatabase.instance.reference().child('users');
  }

  Future<void> createUser(User user) async {
    await _usersRef
        .child(user.id)
        .set({'id': user.id, 'name': user.name, 'photoURL': user.photoURL});
  }
}
