import 'dart:async';

import '../../locator.dart';
import '../models/game.dart';
import '../services/database.dart';

/*
 * Provide game state and handle input
 */
abstract class GameEngine {
  Stream<Game> get gameStream;

  initialize();

  move(int position);
}

class GameEngineLocal extends GameEngine {
  final _controller;
  Game _game;

  GameEngineLocal({required Game game})
      : _game = game,
        _controller = _createStreamController(game);

  static StreamController<Game> _createStreamController(Game game) {
    final controller = StreamController<Game>();
    controller.add(game);
    return controller;
  }

  initialize() {}

  @override
  Stream<Game> get gameStream => _controller.stream;

  @override
  move(int position) {
    if (_game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      _controller.add(_game);
    }
  }
}

class GameEngineRemote extends GameEngine {
  final _databaseService = locator<DatabaseService>();
  final String _gameId;
  late Game _game;

  GameEngineRemote({required String gameId}) : _gameId = gameId;

  initialize() {
    _databaseService.gameStream(_gameId).listen((game) {
      _game = game;
    });
  }

  @override
  Stream<Game> get gameStream => _databaseService.gameStream(_gameId);

  @override
  move(int position) async {
    if (_game.status() == Game.STATUS_NO_WINNERS_YET &&
        _game.possibleMoves().contains(position)) {
      _game.performMove(position);
      _databaseService.updateGame(_gameId, _game);
    }
  }
}
