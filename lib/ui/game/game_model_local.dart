import '../../data/models/game.dart';
import '../../data/services/minimax_ai.dart';
import 'game_model.dart';

class GameModelLocal extends GameModel {
  final MiniMaxAi _ai = MiniMaxAi();

  bool _loading = true;
  late Game _game;
  late String _controlledPlayer;
  late String _aiPlayer;

  bool get loading => _loading;

  List<String> get board => _game.board;

  bool get yourTurn => _game.turn == _controlledPlayer;

  Outcome? get outcome => _getOutcome();

  load() {
    _game = Game.newGame();
    _controlledPlayer = Game.P1;
    _aiPlayer = Game.P2;
    _loading = false;
    _runAi();
  }

  tap(int position) {
    if (_game.turn == _controlledPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      notifyListeners();
      _runAi();
    }
  }

  Outcome? _getOutcome() {
    final status = _game.status();
    if (status == Game.STATUS_NO_WINNERS_YET) {
      return null;
    } else if (status == Game.STATUS_DRAW) {
      return Outcome.draw;
    } else if (status == _controlledPlayer) {
      return Outcome.win;
    } else {
      return Outcome.loose;
    }
  }

  _runAi() {
    if (_game.turn == _aiPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET) {
      int bestMove = _ai.findBestMove(_game);
      Future.delayed(const Duration(milliseconds: 1000), () {
        _game.performMove(bestMove);
        notifyListeners();
      });
    }
  }

  exit() {}
}
