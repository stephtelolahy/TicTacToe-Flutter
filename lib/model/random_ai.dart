import 'dart:math';

import 'game.dart';

class RandomAi {
  int findBestMove(Game game) {
    final random = new Random();
    final moves = game.possibleMoves();
    return moves[random.nextInt(moves.length)];
  }
}
