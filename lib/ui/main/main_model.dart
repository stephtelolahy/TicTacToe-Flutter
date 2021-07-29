import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/services/auth.dart';
import '../../locator.dart';

class MainModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  bool? _signedIn;

  bool? get signedIn => _signedIn;

  initialize() async {
    _authService.observeAuthState((userId) {
      _signedIn = userId != null;
      notifyListeners();
    });
  }
}
