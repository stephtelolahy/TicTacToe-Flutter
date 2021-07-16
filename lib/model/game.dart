class Game {
  static const int HUMAN = 1;
  static const int AI_PLAYER = -1;
  static const int EMPTY_SPACE = 0;

  static const int STATUS_NO_WINNERS_YET = 0;
  static const int STATUS_DRAW = 2;

  static const WIN_CONDITIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  List<int> board = List.generate(9, (idx) => EMPTY_SPACE);
  int turn = HUMAN;

  void performMove(int position) {
    if (board[position] != EMPTY_SPACE) {
      print("Illegal move");
      return;
    }

    board[position] = turn;
    turn = -1 * turn;
  }

  int status() {
    for (var row in WIN_CONDITIONS) {
      if (board[row[0]] != EMPTY_SPACE &&
          board[row[0]] == board[row[1]] &&
          board[row[0]] == board[row[2]]) {
        return board[row[0]];
      }
    }

    if (board.every((e) => e != EMPTY_SPACE)) {
      return STATUS_DRAW;
    }

    return STATUS_NO_WINNERS_YET;
  }

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