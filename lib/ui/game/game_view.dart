import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_model.dart';
import 'widget/field_widget.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
        create: (context) => GameModel(),
        child: Consumer<GameModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    title: Text("Tic Tac Toe Flutter"),
                  ),
                  body: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(60),
                        child: Text( "Your turn ${model.turn}",
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
                )));
  }
}
