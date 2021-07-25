import 'package:flutter/material.dart';

abstract class GameModel extends ChangeNotifier {
  bool get loading;

  List<String> get board;

  bool get yourTurn;

  Outcome? get outcome;

  load();

  tap(int position);

  exit();
}

enum Outcome { win, loose, draw }
