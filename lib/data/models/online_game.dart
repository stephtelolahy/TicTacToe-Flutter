class OnLineGame {
  List<int> board;
  int turn;

  // Matching player to firebase user
  // requires the key type to be String
  final Map<String, String> users;

  OnLineGame(this.board, this.turn, this.users);

  OnLineGame.fromJson(Map<String, Object?> json)
      : board = json['board'] as List<int>,
        turn = json['turn'] as int,
        users = json['users'] as Map<String, String>;

  Map<String, Object> toJson() {
    return {'board': board, 'turn': turn, 'users': users};
  }
}
