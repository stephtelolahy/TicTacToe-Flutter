import 'package:flutter/material.dart';

import '../../core/game.dart';
import '../../core/minimax_ai.dart';

class GameModel extends ChangeNotifier {
  static const SYMBOLS = {
    Game.EMPTY_SPACE: "",
    Game.HUMAN: "X",
    Game.AI_PLAYER: "O"
  };

  Game _game = Game(
      board: List.generate(9, (idx) => Game.EMPTY_SPACE), turn: Game.HUMAN);

  MiniMaxAi _ai = MiniMaxAi();

  // properties

  List<String> get board => _game.board.map((e) => SYMBOLS[e]!).toList();

  String get turn => SYMBOLS[_game.turn]!;

  bool get isYourTurn => _game.turn == Game.HUMAN;

  int get status => _game.status();

  // actions

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
