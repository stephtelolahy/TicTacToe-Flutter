class User {
  final String id;
  final String name;
  final String photoURL;
  final int score;

  User(this.id, this.name, this.photoURL, this.score);

  User.fromJson(Map<String, Object?> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        photoURL = json['photoURL'] as String,
        score = (json['score'] as int?) ?? 0;

  Map<String, Object> toJson() {
    return {'id': id, 'name': name, 'photoURL': photoURL};
  }
}
