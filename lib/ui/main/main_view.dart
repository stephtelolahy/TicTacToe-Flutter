import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/ui/home/home_view.dart';
import 'package:tictactoe/ui/login/login_view.dart';
import 'package:tictactoe/ui/main/main_model.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(create: (context) {
      final model = MainModel();
      model.initialize();
      return model;
    }, child: Consumer<MainModel>(builder: (context, model, child) {
      switch (model.userState) {
        case UserState.unknown:
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case UserState.signedIn:
          return HomeView();

        case UserState.signedOut:
          return LoginView();
      }
    }));
  }
}
