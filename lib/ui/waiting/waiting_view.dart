import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe Flutter"),
        ),
        body: Center(child: CircularProgressIndicator()),
    );
  }
}
