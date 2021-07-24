import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  late DatabaseReference _usersRef;

  void initialize() {
    _usersRef = FirebaseDatabase.instance.reference().child('users');
  }

  Future<void> createUser(String id, String? name, String? photoURL) async {
    final value = {
      'id': id,
      'name': name ?? id,
      'photoURL': photoURL
    };
    await _usersRef.child(id).set(value);
  }
}
