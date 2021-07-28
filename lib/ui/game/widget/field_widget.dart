import 'package:flutter/material.dart';

class FieldWidget extends StatelessWidget {
  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;

  FieldWidget({required this.idx, required this.playerSymbol, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(idx),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(border: _borderAt(idx)),
        child: Center(child: Text(playerSymbol, style: TextStyle(fontSize: 50))),
      ),
    );
  }

  final BorderSide _borderSide = BorderSide(color: Colors.amber, width: 2.0, style: BorderStyle.solid);

  Border _borderAt(int idx) {
    Border border = Border.all();

    switch (idx) {
      case 0:
        border = Border(bottom: _borderSide, right: _borderSide);
        break;
      case 1:
        border = Border(left: _borderSide, bottom: _borderSide, right: _borderSide);
        break;
      case 2:
        border = Border(left: _borderSide, bottom: _borderSide);
        break;
      case 3:
        border = Border(bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 4:
        border = Border(left: _borderSide, bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 5:
        border = Border(left: _borderSide, bottom: _borderSide, top: _borderSide);
        break;
      case 6:
        border = Border(right: _borderSide, top: _borderSide);
        break;
      case 7:
        border = Border(left: _borderSide, top: _borderSide, right: _borderSide);
        break;
      case 8:
        border = Border(left: _borderSide, top: _borderSide);
        break;
    }

    return border;
  }
}
