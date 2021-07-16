import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe Flutter"),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome text
              Text(
                "Welcome to Flutter Tic Tac Toe!",
                style: TextStyle(fontSize: 20),
              ),
              // New game button
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(32, 16, 32, 16)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ))),
                child: Text(
                  "New game!",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/game');
                },
              ),
              // Win statistic widget
              Text("No wins yet!", style: TextStyle(fontSize: 15)),
            ],
          ),
        ));
  }
}
