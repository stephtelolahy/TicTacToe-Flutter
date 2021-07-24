import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class WaitingModel {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  exit() {
    _databaseService.setStatus(_authService.userId(), UserStatusIdle());
  }
}
