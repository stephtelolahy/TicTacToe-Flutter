import 'game.dart';

class MiniMaxAi {
  static const int WIN_SCORE = 100;
  static const int DRAW_SCORE = 0;
  static const int LOSE_SCORE = -100;

  int findBestMove(Game game) {
    return _getBestMove(game, game.turn).position;
  }

  /// Returns the best possible score for a certain board condition.
  /// This method implements the stopping condition.
  int _getBestScore(Game game, String player) {
    String status = game.status();

    if (status == player) return WIN_SCORE;

    if (status == Game.opponent(player)) return LOSE_SCORE;

    if (status == Game.STATUS_DRAW) return DRAW_SCORE;

    return _getBestMove(game, player).score;
  }

  /// This is where the actual Minimax algorithm is implemented
  Move _getBestMove(Game game, String player) {
    // try all possible moves
    List<int> newBoard;
    // will contain our next best score
    Move bestMove = Move(position: -1, score: -10000);

    List<int> possibleMoves = game.possibleMoves();
    for (var i = 0; i < possibleMoves.length; i++) {
      int position = possibleMoves[i];

      // we need a copy of the initial board so we don't pollute our real board
      Game newGame = Game(board: List.from(game.board), turn: game.turn);

      // make the move
      newGame.performMove(position);

      // solve for the next player
      // what is a good score for the opposite player is opposite of good score for us
      int nextScore = -_getBestScore(newGame, newGame.turn);

      // check if the current move is better than our best found move
      if (nextScore > bestMove.score) {
        bestMove.score = nextScore;
        bestMove.position = position;
      }
    }

    return bestMove;
  }
}

class Move {
  int position;
  int score;

  Move({required this.position, required this.score});
}
