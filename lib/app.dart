import 'package:flutter/material.dart';

import 'routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.amber),
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
