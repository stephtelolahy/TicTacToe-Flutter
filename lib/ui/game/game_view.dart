import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/game.dart';
import 'game_model.dart';
import 'widget/field_widget.dart';

class GameView extends StatelessWidget {
  // Online Game identifier
  // If null, then load local game VS AI
  final String? gameId;

  GameView(this.gameId);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
        create: (context) {
          final model = GameModel();
          model.initialize(gameId);
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
    var title = "";
    if (model.status == Game.STATUS_NO_WINNERS_YET) {
      String symbol = model.turn;
      if (model.isYourTurn) {
        title = "Your turn $symbol";
      } else {
        title = "Wait opponent's turn $symbol";
      }
    } else if (model.status == Game.STATUS_DRAW) {
      title = "Draw!";
    } else if (model.status == model.controlledPlayer) {
      title = "You win, Congratulations!";
    } else {
      title = "You lose :(";
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
