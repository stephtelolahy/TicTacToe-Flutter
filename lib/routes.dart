import 'package:flutter/material.dart';

import 'ui/game/game_view.dart';
import 'ui/home/home_view.dart';
import 'ui/leaderboard/leaderboard_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomeView());
    case '/game':
      return MaterialPageRoute(builder: (_) {
        final args = settings.arguments as GameArguments? ?? GameArguments('', '');
        return GameView(args);
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
