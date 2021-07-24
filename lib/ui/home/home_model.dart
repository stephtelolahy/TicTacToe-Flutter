import 'package:flutter/material.dart';

import '../../data/services/auth.dart';
import '../../locator.dart';

class HomeModel extends ChangeNotifier {
  final _authService = locator<AuthService>();

  String get userName => _authService.userName();

  // actions

  Future<void> logout() async {
    await _authService.signOut();
  }
}
