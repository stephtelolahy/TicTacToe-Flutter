abstract class UserStatus {}

class UserStatusIdle extends UserStatus {}

class UserStatusWaiting extends UserStatus {}

class UserStatusPlaying extends UserStatus {
  final String gameId;
  final int player;

  UserStatusPlaying(this.gameId, this.player);
}
