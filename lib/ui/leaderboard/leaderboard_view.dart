import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user.dart';
import '../game/widget/avatar_widget.dart';
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
                      itemBuilder: (context, index) {
                        final user = model.users[index];
                        final highlighted = model.selectedUserId == user.id;
                        return _userWidget(context, user, highlighted, index + 1);
                      }),
                )));
  }

  _userWidget(BuildContext context, User user, bool highlighted, int rank) {
    return ListTile(
      tileColor: highlighted ? Theme.of(context).highlightColor : Theme.of(context).primaryColor,
      title: Text("$rank. ${user.name}"),
      leading: AvatarWidget(user.photoURL),
      trailing: Text(
        "${user.score}",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}
