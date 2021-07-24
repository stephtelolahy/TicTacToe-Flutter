import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'waiting_model.dart';

class WaitingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe Flutter"),
          actions: [
            IconButton(
                icon: Icon(Icons.close_outlined),
                onPressed: () => WaitingModel().exit())
          ],
        ),
        body: Center(
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
        ));
  }
}
