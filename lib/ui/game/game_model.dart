import 'package:flutter/material.dart';

import '../../data/engine/game.dart';
import '../../data/engine/minimax_ai.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

class GameModel extends ChangeNotifier {
  static const _SYMBOLS = {Game.EMPTY_SPACE: "", Game.P1: "X", Game.P2: "O"};

  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();
  final int _controlledPlayer = Game.P1;
  final int _aiPlayer = Game.P2;

  Game _game = Game.newGame();
  MiniMaxAi _ai = MiniMaxAi();

  // states

  List<String> get board => _game.board.map((e) => _SYMBOLS[e]!).toList();

  String get turn => _SYMBOLS[_game.turn]!;

  bool get isYourTurn => _game.turn == _controlledPlayer;

  int get status => _game.status();

  // actions

  tap(int position) {
    if (_game.turn == _controlledPlayer &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      notifyListeners();
      update();
    }
  }

  update() {
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
