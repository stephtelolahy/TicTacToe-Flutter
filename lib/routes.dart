import 'package:flutter/material.dart';

import 'ui/game/game_view.dart';
import 'ui/main/main_view.dart';

Map<String, WidgetBuilder> routes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => MainView(),
      '/game': (BuildContext context) => GameView(null, null)
    };
