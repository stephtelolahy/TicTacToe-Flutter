import '../../data/models/game.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';
import 'game_model.dart';

class GameModelRemote extends GameModel {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  final String gameId;

  bool _loading = true;
  late Game _game;
  late String _controlledPlayer;

  GameModelRemote(this.gameId);

  bool get loading => _loading;

  List<String> get board => _game.board;

  bool get yourTurn => _game.turn == _controlledPlayer;

  Outcome? get outcome => null;

  load() {
    _controlledPlayer = _authService.userId();
    // TODO: observe game
    // TODO: load users
  }

  tap(int position) {
    if (_game.turn == _controlledPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      // TODO: update game
      notifyListeners();
    }
  }

  exit() {
    _databaseService.setStatus(_authService.userId(), UserStatusIdle());
  }
}
