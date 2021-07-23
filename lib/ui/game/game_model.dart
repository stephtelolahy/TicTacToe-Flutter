import 'package:flutter/material.dart';

import '../../core/game.dart';
import '../../core/minimax_ai.dart';

class GameModel extends ChangeNotifier {
  static const SYMBOLS = {
    Game.EMPTY_SPACE: "",
    Game.HUMAN: "X",
    Game.AI_PLAYER: "O"
  };

  Game _game = Game.newGame();

  MiniMaxAi _ai = MiniMaxAi();

  // states

  List<String> get board => _game.board.map((e) => SYMBOLS[e]!).toList();

  String get turn => SYMBOLS[_game.turn]!;

  bool get isYourTurn => _game.turn == Game.HUMAN;

  int get status => _game.status();

  // actions

  void update() {
    if (_game.turn == Game.AI_PLAYER &&
        _game.status() == Game.STATUS_NO_WINNERS_YET) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        int bestMove = _ai.findBestMove(_game);
        _game.performMove(bestMove);
        notifyListeners();
      });
    }
  }

  void tap(int position) {
    if (_game.turn == Game.HUMAN &&
        _game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      notifyListeners();
      update();
    }
  }

  void restart() {
    _game = Game.newGame();
    notifyListeners();
    update();
  }
}
