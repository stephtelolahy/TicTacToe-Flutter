import 'package:flutter/material.dart';

import '../../model/game.dart';

class GameModel extends ChangeNotifier {
  static const SYMBOLS = {
    Game.EMPTY_SPACE: "",
    Game.HUMAN: "X",
    Game.AI_PLAYER: "O"
  };

  Game _game = Game();

  List<String> get board => _game.board.map((e) => SYMBOLS[e]!).toList();

  String get turn => SYMBOLS[_game.turn]!;

  int get status => _game.status();

  void tap(int position) {
    _game.performMove(position);
    notifyListeners();
  }

  void restart() {
    _game = Game();
    notifyListeners();
  }
}
