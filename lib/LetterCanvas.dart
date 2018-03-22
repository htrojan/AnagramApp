import 'dart:math';

import 'package:flutter/material.dart';

class LetterCanvas extends StatefulWidget {

  LetterCanvas(this._letters);

  LetterCanvas.fromString(String string) : _letters = string.runes.toList(){
    _letters.shuffle();
  }

  final List<int> _letters;

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
    var rnd = new Random();
    int alreadyUsed = 0;

    return new List.generate(rowCount, (index) {
      int num = (index == rowCount-1) ? (maxUsed - alreadyUsed) : (rnd.nextInt(maxPerRow) + 1);
      if(num > maxUsed - alreadyUsed) {
        num = 0;
      }
      var row = new Expanded(
//        constraints: const BoxConstraints(maxHeight: 100.0),
        child: new Row(

//        mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget._letters.skip(alreadyUsed).take(num).map((rune) {
            return new GestureDetector(
              child: new Container(
                constraints: const BoxConstraints.tightFor(height: 90.0, width: 90.0),
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