import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user.dart';
import 'leaderboard_model.dart';

class LeaderboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LeaderboardModel>(
        create: (context) {
          final model = LeaderboardModel();
          model.initialize();
          return model;
        },
        child: Consumer<LeaderboardModel>(
            builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
                    title: Text("Leaderboard"),
                  ),
                  body: ListView.builder(
                      itemCount: model.users.length,
                      itemBuilder: (context, index) =>
                          _userWidget(context, model.users[index])),
                )));
  }

  _userWidget(BuildContext context, User user) {
    return ListTile(
      title: Text(user.name),
      leading: Icon(Icons.face),
      trailing: Text(
        '${user.score}',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }
}
