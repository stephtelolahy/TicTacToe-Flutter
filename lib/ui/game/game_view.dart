import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_model.dart';
import 'widget/field_widget.dart';

class GameView extends StatelessWidget {
  // Online Game identifier
  // If null, then load local game VS AI
  final String? gameId;
  final String? controlledPlayer;

  GameView(this.gameId, this.controlledPlayer);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
        create: (context) {
          final model = GameModel();
          if (gameId != null && controlledPlayer != null) {
            model.initializeRemoteGame(gameId!, controlledPlayer!);
          } else {
            model.initializeLocalGame();
          }
          return model;
        },
        child: Consumer<GameModel>(
            builder: (context, model, child) => Scaffold(
                appBar: AppBar(
                  title: Text("Tic Tac Toe Flutter"),
                  actions: [
                    IconButton(
                        onPressed: () => model.exit(),
                        icon: Icon(Icons.close_outlined))
                  ],
                ),
                body: model.board != null
                    ? _boardWidget(model, context)
                    : _loaderWidget(context))));
  }

  Widget _boardWidget(GameModel model, BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(48),
              child: Text(_displayText(model.message),
                  style: TextStyle(fontSize: 25)),
            ),
            Container(
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
            ),
          ],
        ));
  }

  String _displayText(Message? message) {
    switch (message) {
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
}
