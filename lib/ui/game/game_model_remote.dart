import '../../data/models/game.dart';
import '../../data/models/user.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';
import 'game_model.dart';

class GameModelRemote extends GameModel {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  final String gameId;
  final String controlledPlayer;

  bool _loading = true;
  late Game _game;
  late Map<String, User> _users;

  GameModelRemote(this.gameId, this.controlledPlayer);

  bool get loading => _loading;

  List<String> get board => _game.board;

  bool get yourTurn => _game.turn == controlledPlayer;

  Outcome? get outcome => null;

  load() {
    _databaseService.gameStream(gameId).listen((game) {
      _game = game;
      _loading = false;
      notifyListeners();
    });

    _databaseService.getGameUsers(gameId).then((users) {
      _users = users;
      notifyListeners();
    });
  }

  tap(int position) {
    if (_game.turn == controlledPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      _databaseService.updateGame(gameId, _game);
    }
  }

  exit() {
    _databaseService.setStatus(_authService.userId(), UserStatusIdle());
  }
}
