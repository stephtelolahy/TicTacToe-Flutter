import 'dart:math';

class Game {
  static const String P1 = 'X';
  static const String P2 = 'O';
  static const String EMPTY_SPACE = '';
  static const String STATUS_NO_WINNERS_YET = 'NO_WINNERS_YET';
  static const String STATUS_DRAW = 'DRAW';

  List<String> board;
  String turn;

  Game({required this.board, required this.turn});

  Game.fromJson(Map<String, Object?> json)
      : board = (json['board'] as List<dynamic>).cast<String>(),
        turn = json['turn'] as String;

  Map<String, Object> toJson() {
    return {'board': board, 'turn': turn};
  }

  static Game newGame() {
    final board = List.generate(9, (idx) => EMPTY_SPACE);
    Random random = new Random();
    final turn = random.nextBool() ? Game.P1 : Game.P2;
    return Game(board: board, turn: turn);
  }

  void performMove(int position) {
    if (board[position] != EMPTY_SPACE) {
      print("Illegal move");
      return;
    }

    board[position] = turn;
    turn = opponent(turn);
  }

  static String opponent(String player) {
    return player == Game.P1 ? Game.P2 : Game.P1;
  }

  String status() {
    for (var row in _WIN_CONDITIONS) {
      if (board[row[0]] != EMPTY_SPACE && board[row[0]] == board[row[1]] && board[row[0]] == board[row[2]]) {
        return board[row[0]];
      }
    }

    if (board.every((e) => e != EMPTY_SPACE)) {
      return STATUS_DRAW;
    }

    return STATUS_NO_WINNERS_YET;
  }

  static const _WIN_CONDITIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  List<int> possibleMoves() {
    List<int> result = [];
    for (var i = 0; i < board.length; i++) {
      if (board[i] == EMPTY_SPACE) {
        result.add(i);
      }
    }
    return result;
  }
}
