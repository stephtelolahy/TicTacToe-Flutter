import 'package:flutter/material.dart';

import '../ui/game/game_view.dart';
import '../ui/home/home_view.dart';

Map<String, WidgetBuilder> routes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => HomeView(),
      '/game': (BuildContext context) => GameView()
    };
