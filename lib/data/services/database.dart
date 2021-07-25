import 'package:cloud_firestore/cloud_firestore.dart';

import '../engine/game.dart';
import '../models/online_game.dart';
import '../models/user.dart';
import '../models/user_status.dart';

class DatabaseService {
  late CollectionReference _usersRef;
  late CollectionReference _statusRef;
  late CollectionReference _gamesRef;

  initialize() {
    _usersRef = FirebaseFirestore.instance.collection('users');
    _statusRef = FirebaseFirestore.instance.collection('user_status');
    _gamesRef = FirebaseFirestore.instance.collection('games');
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
    // if two waiting users,
    // then create a new game
    // and update their statuses
    _statusRef
        .where('waiting', isEqualTo: true)
        .limit(2)
        .get()
        .then((snapshot) async {
      if (snapshot.size == 2) {
        final userIds = snapshot.docs.map((e) => e.id);
        await _createGame(userIds);
      }
    });
  }

  _createGame(Iterable<String> userIds) async {
    final board = List.generate(9, (idx) => Game.EMPTY_SPACE);
    final turn = Game.P1;
    final Map<String, String> users = {
      Game.P1.toString(): userIds.first,
      Game.P2.toString(): userIds.last
    };
    final game = OnLineGame(board, turn, users);
    final gameRef = await _gamesRef.add(game.toJson());
    final gameId = gameRef.id;

    users.forEach((playerId, userId) {
      setStatus(userId, UserStatusPlaying(gameId, playerId));
    });
  }
}
