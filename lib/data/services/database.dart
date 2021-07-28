import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/game.dart';
import '../models/user.dart';
import '../models/user_status.dart';

class DatabaseService {
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference _statusRef = FirebaseFirestore.instance.collection('user_status');
  final CollectionReference _gamesRef = FirebaseFirestore.instance.collection('games');

  Future<void> createUser(User user) {
    return _usersRef.doc(user.id).set(user.toJson());
  }

  Future<void> setStatus(String id, UserStatus status) {
    final value = status.toJson();
    if (value != null) {
      return _statusRef.doc(id).set(value);
    } else {
      return _statusRef.doc(id).delete();
    }
  }

  Stream<UserStatus> userStatusStream(String id) {
    return _statusRef.doc(id).snapshots().map((event) {
      final value = event.data() as Map<String, Object?>?;
      return UserStatus.fromJson(value);
    });
  }

  Future<void> match() async {
    // if two waiting users,
    // then create a new game
    // and update their statuses
    final snapshot = await _statusRef.where('waiting', isEqualTo: true).limit(2).get();
    if (snapshot.size == 2) {
      final userIds = snapshot.docs.map((e) => e.id);
      await _createGame(userIds);
    }
  }

  _createGame(Iterable<String> userIds) async {
    final game = Game.newGame();
    final gameRef = await _gamesRef.add(game.toJson());
    final gameId = gameRef.id;

    final Map<String, String> users = {Game.P1: userIds.first, Game.P2: userIds.last};

    await _gamesRef.doc(gameId).update({'users': users});

    users.forEach((playerId, userId) {
      setStatus(userId, UserStatusPlaying(gameId, playerId));
    });
  }

  Stream<Game> gameStream(String id) {
    return _gamesRef.doc(id).snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, Object?>;
      return Game.fromJson(data);
    });
  }

  Future<Map<String, User>> getGameUsers(String id) async {
    final snapshot = await _gamesRef.doc(id).get();
    final users = snapshot.get('users') as Map<String, dynamic>;
    Map<String, User> result = Map();
    for (var key in users.keys) {
      final userId = users[key] as String;
      result[key] = await _getUser(userId);
    }
    return result;
  }

  Future<User> _getUser(String id) async {
    final snapshot = await _usersRef.doc(id).get();
    final data = snapshot.data() as Map<String, Object?>;
    return User.fromJson(data);
  }

  Future<void> updateGame(String id, Game game) {
    return _gamesRef.doc(id).set(game.toJson());
  }

  Future<List<User>> getLeaderboard() async {
    final snapshot = await _usersRef.get();
    List<User> result = [];
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, Object?>;
      final user = User.fromJson(data);
      result.add(user);
    }

    result.sort((user1, user2) => user2.score - user1.score);

    return result;
  }

  Future<void> incrementScore(String id) async {
    final user = await _getUser(id);
    await _usersRef.doc(id).update({'score': user.score + 1});
  }
}
