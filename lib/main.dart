import 'package:flutter/material.dart';
import 'ui/HomeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: HomeView(),
    );
  }
}