import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/LetterBox.dart';

typedef void LetterCallback(int letter);


class LetterCanvas extends StatefulWidget {

  LetterCanvas(this._letters, this._callback);

  LetterCanvas.fromString(String string, this._callback) : _letters = string.runes.toList(){
    _letters.shuffle();
  }

  final List<int> _letters;
  final LetterCallback _callback;
  final int _rowCount = 3;

  @override
  _LetterCanvasState createState() => new _LetterCanvasState();
}

class _LetterCanvasState extends State<LetterCanvas> {
  
  
  final Random _rnd = new Random();
  final List<Color> _rndColors = [Colors.yellow, Colors.amber, Colors.red];
  Set<int> _indexesDeactivated;
  List<Color> _colors;

  List<int> _boxesPerRow;

  @override
  void initState(){
    super.initState();
    final int maxUsed = widget._letters.length;
    final int maxPerRow = (maxUsed / widget._rowCount).round() + 1;
    int alreadyUsed = 0;

    _boxesPerRow = new List.generate(widget._rowCount, (index){
      int num = (index == widget._rowCount-1) ? (maxUsed - alreadyUsed) : (_rnd
          .nextInt(maxPerRow) + 1);
      if (num > maxUsed - alreadyUsed) {
        num = 0;
      }

      return num;
    });

    _indexesDeactivated = new Set();

    //Now fill the _color list
    _colors = new List();
    _rndColors.forEach((color){
      _colors.addAll(new List.filled(maxPerRow, color));
    });
    _colors.shuffle();
  }

  void _disableIndex(int index){
    setState((){
      _indexesDeactivated.add(index);
      debugPrint((index).toString() + ' was added to pressed buttons');
    });
  }

  List<Widget> _generateRandomLayout() {
    int currentIndex = 0;

    return _boxesPerRow.map((rowCount){

      return new Expanded(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget._letters.skip(currentIndex).take(rowCount).map((rune){
              currentIndex++; //A 'custom' made index to keep track of each letter
              //As it is incremented before the return statement, all variables inside the return statement
              //have to use currentIndex-1
              final i = currentIndex-1;
              return new GestureDetector(

                onTap: () {
                  _disableIndex(i);
                  widget._callback(rune);
                },
                child: new LetterBox(
                  (_indexesDeactivated.contains(i)) ? Colors.grey :_colors[i],
                  new String.fromCharCode(rune).toUpperCase(),
                ),
              );

            }).toList(),
          )
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _generateRandomLayout()
    );
  }
}