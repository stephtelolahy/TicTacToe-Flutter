import 'package:flutter/cupertino.dart';

import '../../data/models/user.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class LeaderboardModel extends ChangeNotifier {
  final _databaseService = locator<DatabaseService>();

  List<User> _users = [];

  List<User> get users => _users;

  initialize() {
    _databaseService.getLeaderboard().then((value) {
      _users = value;
      notifyListeners();
    });
  }
}
