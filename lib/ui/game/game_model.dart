import 'package:flutter/material.dart';

import '../../data/models/game.dart';
import '../../data/services/minimax_ai.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class GameModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  bool _loading = true;
  late Game _game;
  late String _controlledPlayer;
  late String? _aiPlayer;
  late MiniMaxAi _ai;

  initialize(String? gameId) {
    if (gameId != null) {
      // remote game
      _controlledPlayer = _authService.userId();
      // TODO: observe game
      // TODO: load users
    } else {
      // local game
      _game = Game.newGame();
      _controlledPlayer = Game.P1;
      _aiPlayer = Game.P2;
      _ai = MiniMaxAi();
      _runAi();
      _loading = false;
    }
  }

  bool get loading => _loading;

  List<String> get board => _game.board;

  String get turn => _game.turn;

  bool get isYourTurn => _game.turn == _controlledPlayer;

  String get status => _game.status();

  String get controlledPlayer => _controlledPlayer;

  // actions

  tap(int position) {
    if (_game.turn == _controlledPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      notifyListeners();
      _runAi();
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

  exit() {
    _databaseService.setStatus(_authService.userId(), UserStatusIdle());
  }
}
