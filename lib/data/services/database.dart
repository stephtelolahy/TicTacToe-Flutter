import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/user_status.dart';

class DatabaseService {
  late CollectionReference _usersRef;
  late CollectionReference _statusRef;

  initialize() {
    _usersRef = FirebaseFirestore.instance.collection('users');
    _statusRef = FirebaseFirestore.instance.collection('user_status');
  }

  Future<void> createUser(User user) {
    return _usersRef.doc(user.id).set(user.toJson());
  }

  Future<void> setStatus(String id, UserStatus status) {
    final value = status.toJson();
    if (value != null) {
      return _statusRef.doc(id).set(status.toJson());
    } else {
      return _statusRef.doc(id).delete();
    }
  }

  observeUserStatus(String id, void onChange(UserStatus status)) {
    _statusRef.doc(id).snapshots().listen((event) {
      final value = event.data() as Map<String, Object?>?;
      onChange(UserStatus.fromJson(value));
    });
  }

  Future<void> match() async {
    // get waiting users,
    // if two, then create a new game
    // and update their statuses
    _statusRef.where('waiting', isEqualTo: true).get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        print('waiting: ${doc.id}');
      });
    });
  }
}
