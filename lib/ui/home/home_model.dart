import 'package:flutter/material.dart';

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

  playOnline() {
    _databaseService.setStatusWaiting(_authService.userId());
  }
}
