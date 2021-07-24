import 'package:flutter/widgets.dart';

import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class LoginModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  Future<void> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      await _databaseService.createUser(user);
    } catch (e) {
      print(e);
    }
  }
}
