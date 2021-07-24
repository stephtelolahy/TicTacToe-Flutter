import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class MainModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  UserStatus? _status;

  UserStatus? get status => _status;

  initialize() async {
    _authService.observeAuthState((userId) {
      if (userId == null) {
        _status = null;
        notifyListeners();
        return;
      }

      _databaseService.observeUserStatus(userId, (status) {
        _status = status;
        notifyListeners();
      });
    });
  }
}
