import 'dart:math';

import 'package:flutter/material.dart';

class LetterCanvas extends StatefulWidget {

  LetterCanvas(this._letters);

  LetterCanvas.fromString(String string) : _letters = string.runes.toList();

  final List<int> _letters;

  @override
  _LetterCanvasState createState() => new _LetterCanvasState();
}

class _LetterCanvasState extends State<LetterCanvas> {


  List<Widget> _generateRandomLayout(final int rowCount) {
    final int maxUsed = widget._letters.length;
    final int maxPerRow = (maxUsed / rowCount).round() + 1;
    var rnd = new Random();
    int alreadyUsed = 0;

    return new List.generate(rowCount, (index) {
      final int num = (index == rowCount) ? (maxUsed - alreadyUsed) : (rnd.nextInt(maxPerRow) + 1);
      debugPrint('Created Row');
      var row = new Row(
        children: widget._letters.skip(alreadyUsed).take(num).map((rune) {
          return new Container(
            child: new Text(new String.fromCharCode(rune)),
          );
        }).toList(),
      );

      alreadyUsed += num;
      return row;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: _generateRandomLayout(3)
      ),
    );
  }
}