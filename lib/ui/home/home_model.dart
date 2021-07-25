import 'package:flutter/material.dart';

import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class HomeModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  String get userName => _authService.userName();

  logout() {
    _authService.signOut();
  }

  Future<void> playOnline() async {
    await _databaseService.setStatus(
        _authService.userId(), UserStatusWaiting());
    await _databaseService.match();
  }
}
