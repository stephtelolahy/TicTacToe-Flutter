import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_view.dart';
import '../login/login_view.dart';
import 'main_model.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(create: (context) {
      final model = MainModel();
      model.initialize();
      return model;
    }, child: Consumer<MainModel>(builder: (context, model, child) {
      if (model.signedIn) {
        return HomeView();
      } else {
        return LoginView();
      }
    }));
  }
}
