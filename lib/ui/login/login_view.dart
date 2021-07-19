import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
        create: (context) {
          final model = LoginModel();
          model.initialize();
          return model;
        },
        child: Consumer<LoginModel>(
            builder: (context, model, child) => Scaffold(
                body: Container(
                    constraints: BoxConstraints.expand(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Welcome text
                          Text(
                            "Flutter Tic Tac Toe!",
                            style: TextStyle(fontSize: 32),
                          ),
                          Text(
                            "To play you will need to signIn first,",
                          ),
                          // New game button
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.fromLTRB(32, 16, 32, 16)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ))),
                            child: Text(
                              "SignIn",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => model.signIn(),
                          )
                        ])))));
  }
}
