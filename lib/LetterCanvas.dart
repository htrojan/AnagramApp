import 'dart:math';

import 'package:flutter/material.dart';

typedef void LetterCallback(int letter);


class LetterCanvas extends StatefulWidget {

  LetterCanvas(this._letters, this._callback);

  LetterCanvas.fromString(String string, this._callback) : _letters = string.runes.toList(){
    _letters.shuffle();
  }

  final List<int> _letters;
  final LetterCallback _callback;

  @override
  _LetterCanvasState createState() => new _LetterCanvasState();
}

class _LetterCanvasState extends State<LetterCanvas> {

  final Random _rnd = new Random();
  final int _maxRnd = 3;
  final List<Color> _rndColors = [Colors.yellow, Colors.amber, Colors.red];

  List<Widget> _generateRandomLayout(final int rowCount) {
    final int maxUsed = widget._letters.length;
    final int maxPerRow = (maxUsed / rowCount).round() + 1;
    int alreadyUsed = 0;

    return new List.generate(rowCount, (index) {
      int num = (index == rowCount - 1) ? (maxUsed - alreadyUsed) : (_rnd
          .nextInt(maxPerRow) + 1);
      if (num > maxUsed - alreadyUsed) {
        num = 0;
      }
      var row = new Expanded(
        child: new Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget._letters.skip(alreadyUsed).take(num).map((rune) {
            return new GestureDetector(
              onTap: (){
                widget._callback(rune);
              },
              child: new Container(
                constraints: const BoxConstraints.tightFor(
                    height: 90.0, width: 90.0),
                decoration: new BoxDecoration(
                  border: new Border.all(width: 5.0),
                  color: _rndColors[_rnd.nextInt(_maxRnd)],
                ),

                child: new Center(
                  child: new Text(
                    new String.fromCharCode(rune).toUpperCase(),
                    style: new TextStyle(
                      fontSize: 80.0,

                    ),

                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );

      alreadyUsed += num;
      return row;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _generateRandomLayout(3)
    );
  }
}