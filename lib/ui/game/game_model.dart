import 'package:flutter/material.dart';
import 'package:tictactoe/model/ai.dart';

import '../../model/game.dart';

class GameModel extends ChangeNotifier {
  Game _game = Game();

  MCTSAi _ai = MCTSAi();

  List<int> get board => _game.board;

  int get turn => _game.turn;

  bool get isYourTurn => _game.turn == Game.HUMAN;

  int get status => _game.status();

  void tap(int position) {
    if (_game.status() != Game.STATUS_NO_WINNERS_YET) {
      return;
    }

    if (_game.turn != Game.HUMAN) {
      return;
    }

    if (!_game.possibleMoves().contains(position)) {
      return;
    }

    _game.performMove(position);
    notifyListeners();

    if (_game.turn == Game.AI_PLAYER && _game.status() == Game.STATUS_NO_WINNERS_YET) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _runAI();
      });
    }
  }

  void restart() {
    _game = Game();
    notifyListeners();
  }

  void _runAI() {
    int bestMove = _ai.findBestMove(_game, 500);
    _game.performMove(bestMove);
    notifyListeners();
  }
}
