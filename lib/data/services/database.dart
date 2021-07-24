import 'package:firebase_database/firebase_database.dart';
import 'package:tictactoe/data/models/user_status.dart';

import '../models/user.dart';

class DatabaseService {
  late DatabaseReference _usersRef;
  late DatabaseReference _statusRef;

  initialize() {
    _usersRef = FirebaseDatabase.instance.reference().child('users');
    _statusRef = FirebaseDatabase.instance.reference().child('user_status');
  }

  Future<void> createUser(User user) async {
    await _usersRef
        .child(user.id)
        .set({'id': user.id, 'name': user.name, 'photoURL': user.photoURL});
  }

  Future<void> setStatusWaiting(String id) async {
    await _statusRef
        .child(id)
        .set({'waiting': true});
  }

  observeUserStatus(String id, void onChange(UserStatus status)) {}
}
