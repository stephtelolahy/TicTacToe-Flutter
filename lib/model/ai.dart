import 'dart:math';

import 'game.dart';

class MCTSAi {
  int findBestMove(Game game, int iterations) {
    final random = new Random();
    final moves = game.possibleMoves();
    int element = moves[random.nextInt(moves.length)];
    return element;
  }
}
