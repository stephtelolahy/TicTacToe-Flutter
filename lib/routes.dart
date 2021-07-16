
import 'package:flutter/material.dart';
import 'ui/GameView.dart';
import 'ui/HomeView.dart';

Map<String, WidgetBuilder> routes() => <String, WidgetBuilder>{
  '/': (BuildContext context) => HomeView(),
  '/game': (BuildContext context) => GameView()
};