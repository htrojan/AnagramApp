import 'package:flutter/material.dart';

class LetterCanvas extends StatefulWidget {

  LetterCanvas(this._letters);

  LetterCanvas.fromString(String string) : _letters = string.runes.toList();

  final List<int> _letters;

  @override
  _LetterCanvasState createState() => new _LetterCanvasState();
}

class _LetterCanvasState extends State<LetterCanvas> {
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemBuilder: (context, index) {
        return new Container(
          child: new Text(widget._letters[index].toString()),
        );
      },
      itemCount: widget._letters.length,
    );
  }
}