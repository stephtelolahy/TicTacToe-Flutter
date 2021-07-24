import 'package:flutter/cupertino.dart';

import '../../data/services/auth.dart';
import '../../locator.dart';

class MainModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  bool _signedIn = false;

  bool get signedIn => _signedIn;

  initialize() async {
    _authService.observeAuthStateChanges((value) {
      _signedIn = value;
      notifyListeners();
    });
  }
}
