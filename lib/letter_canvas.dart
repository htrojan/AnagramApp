import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/letter_box.dart';

typedef void LetterCallback(int letter, Color letterColor);


class LetterCanvas extends StatefulWidget {

  LetterCanvas(this.word, this._callback, {Key key}) : super(key: key);

  final LetterCallback _callback;
  final int _rowCount = 3;
  final String word;

  @override
  _LetterCanvasState createState() => new _LetterCanvasState(word);
}

class _LetterCanvasState extends State<LetterCanvas> {
  
  
  final Random _rnd = new Random();
  final List<Color> _rndColors = [Colors.yellow, Colors.amber, Colors.red];
  Set<int> _indexesDeactivated;
  List<Color> _colors;

  List<int> _boxesPerRow;
  final List<int> _letters;

  _LetterCanvasState(String word) : _letters = word.runes.toList();

  @override
  void initState(){
    debugPrint('initState() was called');
    super.initState();
    _letters.shuffle(_rnd);

    final int maxUsed = _letters.length;
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
      _colors.addAll(new List.filled(maxPerRow-1, color));
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
            children: _letters.skip(currentIndex).take(rowCount).map((rune){
              currentIndex++; //A 'custom' made index to keep track of each letter
              //As it is incremented before the return statement, all variables inside the return statement
              //have to use currentIndex-1
              final i = currentIndex-1;
              return new GestureDetector(

                onTap: () {
                  if(_indexesDeactivated.contains(i))
                    return;

                  _disableIndex(i);
                  widget._callback(rune, _colors[i]);
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

  @override
  void dispose() {
    super.dispose();
    debugPrint('LetterCanvas disposed!');
  }
}