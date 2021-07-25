class OnLineGame {
  List<String> board;
  String turn;
  final Map<String, String> users;

  OnLineGame(this.board, this.turn, this.users);

  OnLineGame.fromJson(Map<String, Object?> json)
      : board = json['board'] as List<String>,
        turn = json['turn'] as String,
        users = json['users'] as Map<String, String>;

  Map<String, Object> toJson() {
    return {'board': board, 'turn': turn, 'users': users};
  }
}
