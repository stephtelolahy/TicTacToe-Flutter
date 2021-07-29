import 'package:flutter/material.dart';

import 'ui/game/game_view.dart';
import 'ui/leaderboard/leaderboard_view.dart';
import 'ui/main/main_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => MainView());
    case '/game':
      return MaterialPageRoute(builder: (_) {
        final args = settings.arguments as GameArguments?;
        final gameId = args?.gameId ?? '';
        final player = args?.player ?? '';
        return GameView(gameId, player);
      });
    case '/leaderboard':
      return MaterialPageRoute(builder: (_) => LeaderboardView());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(child: Text('No route defined for ${settings.name}')),
              ));
  }
}
