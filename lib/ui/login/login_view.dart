import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'login_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Welcome text
                  Text(
                    "Flutter Tic Tac Toe!",
                    style: TextStyle(fontSize: 32),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "To play you will need to signIn first,",
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  // SignIn button
                  SignInButton(
                    Buttons.Google,
                    onPressed: () => LoginModel().signInWithGoogle(),
                  ),
                ])));
  }
}
