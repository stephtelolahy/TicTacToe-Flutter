import 'package:firebase_database/firebase_database.dart';

import '../models/user.dart';
import '../models/user_status.dart';

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

  Future<void> setStatus(String id, UserStatus status) async {
    if (status is UserStatusWaiting) {
      await _statusRef.child(id).set({'waiting': true});
    } else if (status is UserStatusIdle) {
      await _statusRef.child(id).remove();
    } else if (status is UserStatusPlaying) {
      await _statusRef
          .child(id)
          .set({'game': status.gameId, 'player': status.player});
    }
  }

  observeUserStatus(String id, void onChange(UserStatus status)) {
    _statusRef.child(id).onValue.listen((Event event) {
      final value = event.snapshot.value;
      if (value is Map) {
        if (value['waiting'] == true) {
          onChange(UserStatusWaiting());
          return;
        }
      }

      onChange(UserStatusIdle());
    });
  }

  Future<void> match() async {
    // get waiting users,
    // if two, then create a new game
    // and update their statuses
    _statusRef.get().then((snapshot) {
      print('_statusRef: ${snapshot?.value}');
    });
  }
}
