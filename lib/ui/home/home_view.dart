import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/ui/game/game_view.dart';

import '../../data/models/user_status.dart';
import 'home_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(create: (context) {
      final model = HomeModel();
      model.initialize();
      return model;
    }, child: Consumer<HomeModel>(builder: (context, model, child) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        _handleStatus(model, context);
      });
      return Scaffold(
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
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
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
          ));
    }));
  }

  _handleStatus(HomeModel model, context) {
    final status = model.status;
    if (status is UserStatusWaiting) {
      _showLoadingDialog(model, context);
    } else if (status is UserStatusPlaying) {
      Navigator.maybePop(context).then((_) {
        Navigator.pushNamed(context, '/game',
            arguments: GameArguments(status.gameId, status.player));
      });
    }
  }

  Future<void> _showLoadingDialog(HomeModel model, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 40,
                ),
                Text("Looking for opponents...", style: TextStyle(fontSize: 17)),
              ],
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                model.cancelWaiting();
              },
            ),
          ],
        );
      },
    );
  }
}
