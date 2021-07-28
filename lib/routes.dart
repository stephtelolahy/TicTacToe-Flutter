import 'package:flutter/material.dart';

import 'data/models/game.dart';
import 'ui/game/game_view.dart';
import 'ui/leaderboard/leaderboard_view.dart';
import 'ui/main/main_view.dart';

Map<String, WidgetBuilder> routes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => MainView(),
      '/game': (BuildContext context) =>
          GameView(gameId: null, player: Game.P1),
      '/leaderboard': (BuildContext context) => LeaderboardView(),
    };
