import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user.dart';
import 'game_model.dart';
import 'widget/field_widget.dart';

class GameArguments {
  final String gameId;
  final String player;

  GameArguments(this.gameId, this.player);
}

class GameView extends StatelessWidget {
  final GameArguments args;

  GameView(this.args);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(create: (context) {
      final model = GameModel();
      if (args.gameId.isNotEmpty) {
        model.initializeRemoteGame(args.gameId, args.player);
      } else {
        model.initializeLocalGame();
      }
      return model;
    }, child: Consumer<GameModel>(builder: (context, model, child) {
      return WillPopScope(
          onWillPop: () => model.exit(),
          child: Scaffold(
              appBar: AppBar(
                title: Text("Tic Tac Toe Flutter"),
              ),
              body: Container(
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    children: [
                      _usersWidget(
                          context, model.opponentPlayer, model.users[model.opponentPlayer]),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(model.message?.displayText() ?? '',
                            style: TextStyle(fontSize: 25)),
                      ),
                      model.board != null ? _boardWidget(model, context) : _loaderWidget(context),
                      _usersWidget(
                          context, model.controlledPlayer, model.users[model.controlledPlayer]),
                    ],
                  ))));
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: user.photoURL.isNotEmpty
                ? Image.network(
                    user.photoURL,
                    height: 36.0,
                    width: 36.0,
                  )
                : Icon(Icons.face)),
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
