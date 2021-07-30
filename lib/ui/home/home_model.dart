import 'package:flutter/material.dart';

import '../../data/models/user.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class HomeModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  User? _user;
  UserStatus _status = UserStatusIdle();

  User? get user => _user;

  UserStatus? get status => _status;

  initialize() {
    _authService.observeAuthState((user) {
      _user = user;
      notifyListeners();

      if (user != null) {
        _databaseService.userStatusStream(user.id).listen((status) {
          _status = status;
          notifyListeners();
        });
      }
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      await _databaseService.createUser(user);
    } catch (e) {
      print(e);
    }
  }

  cancelWaiting() {
    final userId = _authService.userId();
    if (userId != null) {
      _databaseService.setStatus(userId, UserStatusIdle());
    }
  }

  signOut() {
    _authService.signOut();
  }

  Future<void> playOnline() async {
    final userId = _authService.userId();
    if (userId != null) {
      await _databaseService.setStatus(userId, UserStatusWaiting());
      await _databaseService.match();
    }
  }
}
