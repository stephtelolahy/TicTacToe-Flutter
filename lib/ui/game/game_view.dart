import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/model/game.dart';

import 'game_model.dart';
import 'widget/field_widget.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
        create: (context) => GameModel(),
        child: Consumer<GameModel>(builder: (context, model, child) {
          if (model.status != Game.STATUS_NO_WINNERS_YET) {
            Future.delayed(const Duration(milliseconds: 1), () {
              _showGameOver(model.status, context);
            });
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Tic Tac Toe Flutter"),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(48),
                  child: Text(
                    "Your turn ${model.turn}",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
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
          );
        }));
  }

  _showGameOver(int winner, BuildContext context) {
    var title = "Game over!";
    var content = "";
    switch (winner) {
      case Game.HUMAN:
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        break;
      case Game.AI_PLAYER:
        title = "Game Over!";
        content = "You lose :(";
        break;
      default:
        title = "Draw!";
        content = "No winners here.";
    }

    showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  new TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Restart"))
                ],
              );
            })
        .then((value) =>
            Provider.of<GameModel>(context, listen: false).restart());
  }
}
