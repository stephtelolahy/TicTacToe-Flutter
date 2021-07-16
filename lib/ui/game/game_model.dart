import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
  static String _P1 = "X";
  static String _P2 = "O";

  List<String> _board = ["", "", "", "", "", "", "", "", ""];
  String _turn = _P1;

  List<String> get board => _board;

  String get turn => _turn;

  void tap(int idx) {
    if (_board[idx].isNotEmpty) {
      print("Illegal move");
      return;
    }

    _board[idx] = turn;
    _turn = _opponent(turn);
    notifyListeners();
  }

  String _opponent(String player) {
    if (player == _P1) {
      return _P2;
    } else {
      return _P1;
    }
  }
}
