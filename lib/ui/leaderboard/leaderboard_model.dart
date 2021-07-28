import 'package:flutter/cupertino.dart';

import '../../data/models/user.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class LeaderboardModel extends ChangeNotifier {
  final _databaseService = locator<DatabaseService>();
  final _authService = locator<AuthService>();

  List<User> _users = [];

  List<User> get users => _users;

  String get userId => _authService.userId();

  initialize() {
    _databaseService.getLeaderboard().then((value) {
      _users = value;
      notifyListeners();
    });
  }
}
