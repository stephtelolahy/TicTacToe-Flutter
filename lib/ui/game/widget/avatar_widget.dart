import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String photoURL;

  AvatarWidget(this.photoURL);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: photoURL.isNotEmpty
            ? Image.network(
                photoURL,
                height: 36.0,
                width: 36.0,
              )
            : Icon(Icons.face));
  }
}
