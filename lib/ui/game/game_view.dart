import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/engine/game.dart';
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
          final model = GameModel(gameId);
          model.initialize();
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
                body: Container(
                  constraints: BoxConstraints.expand(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                  ),
                ))));
  }

  Widget _header(GameModel model, BuildContext context) {
    var title = "Game over!";
    switch (model.status) {
      case Game.P1:
        title = "Congratulations!";
        break;
      case Game.P2:
        title = "You lose :(";
        break;

      case Game.STATUS_DRAW:
        title = "Draw!";
        break;

      default:
        String symbol = model.turn;
        title = "${model.isYourTurn ? "Your" : "CPU"} turn $symbol";
        break;
    }

    return Text(title, style: TextStyle(fontSize: 25));
  }
}
