import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/game.dart';
import '../../data/models/user.dart';
import 'game_model.dart';
import 'widget/field_widget.dart';

class GameView extends StatelessWidget {
  final String? gameId;
  final String player;

  GameView({this.gameId, required this.player});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(create: (context) {
      final model = GameModel();
      if (gameId != null) {
        model.initializeRemoteGame(gameId!, player);
      } else {
        model.initializeLocalGame(player);
      }
      return model;
    }, child: Consumer<GameModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Tic Tac Toe Flutter"),
            actions: [IconButton(onPressed: () => model.exit(), icon: Icon(Icons.close_outlined))],
          ),
          body: Container(
              constraints: BoxConstraints.expand(),
              child: Column(
                children: [
                  _usersWidget(context, Game.P1, model.users[Game.P1]),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(model.message?.displayText() ?? '', style: TextStyle(fontSize: 25)),
                  ),
                  model.board != null ? _boardWidget(model, context) : _loaderWidget(context),
                  _usersWidget(context, Game.P2, model.users[Game.P2]),
                ],
              )));
    }));
  }

  Widget _boardWidget(GameModel model, BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (idx) {
          return FieldWidget(
            idx: idx,
            onTap: (idx) => model.tap(idx),
            playerSymbol: model.board![idx],
          );
        }),
      ),
    );
  }

  Widget _loaderWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 40,
          ),
          Text("Loading game...", style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  Widget _usersWidget(BuildContext context, String player, User? user) {
    if (user == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Image.network(
              user.photoURL,
              height: 36.0,
              width: 36.0,
            )),
        Text("$player ${user.name}", style: TextStyle(fontSize: 17)),
      ],
    );
  }
}

extension Displaying on Message {
  String displayText() {
    switch (this) {
      case Message.yourTurn:
        return "Your turn";
      case Message.opponentTurn:
        return "Wait opponent's turn";
      case Message.win:
        return "You win 🎉";
      case Message.draw:
        return "Draw!";
      case Message.loose:
        return "You lose :(";
      default:
        return "";
    }
  }
}
