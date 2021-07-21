import 'package:flutter/material.dart';

import '../ui/game/game_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';

Map<String, WidgetBuilder> routes() => <String, WidgetBuilder>{
      '/': (BuildContext context) => LoginView(),
      '/home': (BuildContext context) => HomeView(),
      '/game': (BuildContext context) => GameView()
    };
