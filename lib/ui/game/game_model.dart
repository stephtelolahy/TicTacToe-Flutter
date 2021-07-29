import 'package:flutter/material.dart';

import '../../data/engine/game_engine.dart';
import '../../data/engine/minimax_ai.dart';
import '../../data/models/game.dart';
import '../../data/models/user.dart';
import '../../data/models/user_status.dart';
import '../../data/services/auth.dart';
import '../../data/services/database.dart';
import '../../locator.dart';

enum Message { yourTurn, opponentTurn, win, loose, draw }

class GameModel extends ChangeNotifier {
  final _authService = locator<AuthService>();
  final _databaseService = locator<DatabaseService>();

  late GameEngine _engine;
  late String _controlledPlayer;
  late String _opponentPlayer;

  MiniMaxAi? _ai;

  Game? _game;
  Message? _message;
  Map<String, User> _users = Map();

  List<String>? get board => _game?.board;

  Message? get message => _message;

  Map<String, User> get users => _users;

  String get controlledPlayer => _controlledPlayer;

  String get opponentPlayer => _opponentPlayer;

  initializeLocalGame() {
    final game = Game.newGame();
    _engine = GameEngineLocal(game: game);
    _engine.initialize();

    _controlledPlayer = Game.P1;
    _opponentPlayer = Game.P2;

    _ai = MiniMaxAi();

    _users = {
      Game.P1: User('', _authService.userName(), _authService.photoURL(), 0),
      Game.P2: User('', 'CPU', '', 0)
    };

    _engine.gameStream.listen((game) {
      _game = game;
      _message = _buildMessage(game);
      notifyListeners();
      _runAi();
    });
  }

  initializeRemoteGame(String gameId, String player) {
    _engine = GameEngineRemote(gameId: gameId);
    _engine.initialize();
    _controlledPlayer = player;
    _opponentPlayer = Game.opponent(player);

    _engine.gameStream.listen((game) {
      _game = game;
      _message = _buildMessage(game);
      _updateScoreIfGameOver(game);
      notifyListeners();
    });

    _databaseService.getGameUsers(gameId).then((users) {
      _users = users;
      notifyListeners();
    });
  }

  Message? _buildMessage(Game game) {
    final status = game.status();
    if (status == Game.STATUS_NO_WINNERS_YET) {
      if (game.turn == _controlledPlayer) {
        return Message.yourTurn;
      } else {
        return Message.opponentTurn;
      }
    } else if (status == Game.STATUS_DRAW) {
      return Message.draw;
    } else if (status == _controlledPlayer) {
      return Message.win;
    } else {
      return Message.loose;
    }
  }

  tap(int position) {
    final game = _game!;
    if (game.turn == _controlledPlayer && game.status() == Game.STATUS_NO_WINNERS_YET) {
      _engine.move(position);
    }
  }

  _runAi() {
    final game = _game!;
    if (_ai != null &&
        game.turn == _opponentPlayer &&
        game.status() == Game.STATUS_NO_WINNERS_YET) {
      int bestMove = _ai!.findBestMove(game);
      Future.delayed(const Duration(milliseconds: 1000), () {
        _engine.move(bestMove);
      });
    }
  }

  _updateScoreIfGameOver(Game game) {
    if (game.status() == _controlledPlayer) {
      _databaseService.incrementScore(_authService.userId());
    }
  }

  exit() {
    _databaseService.setStatus(_authService.userId(), UserStatusIdle());
  }
}
