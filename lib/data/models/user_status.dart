abstract class UserStatus {
  Map<String, Object>? toJson() {
    if (this is UserStatusWaiting) {
      return {'waiting': true};
    } else if (this is UserStatusPlaying) {
      final status = this as UserStatusPlaying;
      return {'gameId': status.gameId, 'player': status.player};
    } else {
      // UserStatusIdle
      return null;
    }
  }

  static UserStatus fromJson(Map<String, Object?>? json) {
    final waiting = json?['waiting'] as bool?;
    if (waiting == true) {
      return UserStatusWaiting();
    }

    final gameId = json?['gameId'] as String?;
    final player = json?['player'] as int?;
    if (gameId != null && player != null) {
      return UserStatusPlaying(gameId, player);
    }

    return UserStatusIdle();
  }
}

class UserStatusIdle extends UserStatus {}

class UserStatusWaiting extends UserStatus {}

class UserStatusPlaying extends UserStatus {
  final String gameId;
  final int player;

  UserStatusPlaying(this.gameId, this.player);
}
