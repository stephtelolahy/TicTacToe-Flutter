import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
        create: (context) {
          return HomeModel();
        },
        child: Consumer<HomeModel>(
            builder: (context, model, child) => Scaffold(
                appBar: AppBar(
                  title: Text("Tic Tac Toe Flutter"),
                  actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => model.logout())],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Welcome text
                      Text(
                        "Welcome ${model.userName}!",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // New game button

                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 16, 32, 16)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60.0),
                            ))),
                        child: Text(
                          "PLAY",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () => model.playOnline(),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        child: Text(
                          "TRAINING",
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game');
                        },
                      ),
                      TextButton(
                        child: Text(
                          "LEADERBOARD",
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
                      ),
                    ],
                  ),
                ))));
  }
}
