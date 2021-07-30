import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

import '../../data/models/user_status.dart';
import '../game/game_view.dart';
import '../game/widget/avatar_widget.dart';
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
        _navigateIfNeeded(model, context);
      });
      return Scaffold(
          appBar: AppBar(
            title: Text("Tic Tac Toe Flutter"),
            actions: model.user != null
                ? [
                    IconButton(
                        icon: AvatarWidget(model.user!.photoURL),
                        onPressed: () => _showSignOutDialog(model, context))
                  ]
                : null,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome text
                Text(
                  "Welcome ${model.user?.name}!",
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
                  onPressed: () =>
                      model.user != null ? model.playOnline() : _showSignInDialog(model, context),
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
                  onPressed: model.user != null
                      ? () => Navigator.pushNamed(context, '/leaderboard')
                      : null,
                ),
              ],
            ),
          ));
    }));
  }

  _navigateIfNeeded(HomeModel model, context) {
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

  Future<void> _showSignInDialog(HomeModel model, BuildContext context) async {
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
                Text("To play you will need to signIn first,", style: TextStyle(fontSize: 17)),
                SizedBox(
                  height: 40,
                ),
                SignInButton(
                  Buttons.Google,
                  onPressed: () {
                    Navigator.pop(context);
                    model.signInWithGoogle();
                  },
                )
              ],
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSignOutDialog(HomeModel model, BuildContext context) async {
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
                Text("Do you really want to signOut ?", style: TextStyle(fontSize: 17)),
              ],
            ),
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context);
                model.signOut();
              },
            ),
          ],
        );
      },
    );
  }
}
