import 'package:flutter/material.dart';
import '../../model/minimax_ai.dart';
import '../../model/random_ai.dart';

import '../../model/game.dart';

class GameModel extends ChangeNotifier {
  Game _game = Game(
      board: List.generate(9, (idx) => Game.EMPTY_SPACE), turn: Game.HUMAN);

  //RandomAi _ai = RandomAi();
  MiniMaxAi _ai = MiniMaxAi();

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

    if (_game.turn == Game.AI_PLAYER &&
        _game.status() == Game.STATUS_NO_WINNERS_YET) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        _runAI();
      });
    }
  }

  void restart() {
    _game = Game(
        board: List.generate(9, (idx) => Game.EMPTY_SPACE), turn: Game.HUMAN);
    notifyListeners();
  }

  void _runAI() {
    int bestMove = _ai.findBestMove(_game);
    _game.performMove(bestMove);
    notifyListeners();
  }
}
