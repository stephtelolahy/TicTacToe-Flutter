import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_model.dart';
import 'game_model_local.dart';
import 'game_model_remote.dart';
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
          GameModel model;
          final gameId = this.gameId;
          final controlledPlayer = this.controlledPlayer;
          if (gameId != null && controlledPlayer != null) {
            model = GameModelRemote(gameId, controlledPlayer);
          } else {
            model = GameModelLocal();
          }
          model.load();
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
                body: model.loading
                    ? _loader(context)
                    : _board(model, context))));
  }

  Widget _board(GameModel model, BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(48),
              child: _header(model, context),
            ),
            Container(
              height: 400,
              width: 400,
              child: GridView.count(
                crossAxisCount: 3,
                // generate the widgets that will display the board
                children: List.generate(9, (idx) {
                  return FieldWidget(
                    idx: idx,
                    onTap: (idx) => model.tap(idx),
                    playerSymbol: model.board[idx],
                  );
                }),
              ),
            ),
          ],
        ));
  }

  Widget _header(GameModel model, BuildContext context) {
    String title;

    switch (model.outcome) {
      case Outcome.win:
        title = "You win 🎉";
        break;

      case Outcome.draw:
        title = "Draw!";
        break;

      case Outcome.loose:
        title = "You lose :(";
        break;

      default:
        if (model.yourTurn) {
          title = "Your turn";
        } else {
          title = "Wait opponent's turn";
        }
    }
    return Text(title, style: TextStyle(fontSize: 25));
  }

  Widget _loader(BuildContext context) {
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
