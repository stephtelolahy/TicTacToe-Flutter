import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/services/auth.dart';
import '../../locator.dart';

class MainModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  bool? _authenticated;

  bool? get authenticated => _authenticated;

  initialize() async {
    _authService.observeAuthState((userId) {
      _authenticated = userId != null;
      notifyListeners();
    });
  }
}
