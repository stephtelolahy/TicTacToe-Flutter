import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_status.dart';
import '../game/game_view.dart';
import '../home/home_view.dart';
import '../login/login_view.dart';
import '../waiting/waiting_view.dart';
import 'main_model.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(create: (context) {
      final model = MainModel();
      model.initialize();
      return model;
    }, child: Consumer<MainModel>(builder: (context, model, child) {
      final status = model.status;
      if (status == null) {
        return LoginView();
      } else if (status is UserStatusIdle) {
        return HomeView();
      } else if (status is UserStatusWaiting) {
        return WaitingView();
      } else if (status is UserStatusPlaying) {
        return GameView();
      } else {
        return Scaffold();
      }
    }));
  }
}
