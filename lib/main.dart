import 'package:flutter/material.dart';

void main() {
  return runApp(
      new MaterialApp(
        title: 'AnnAgram',
        home: new Anagram(new AnagramData('abbabb', 'ababbb')),
      )
  );
}

class AnagramData {

  AnagramData(this.word1, this.word2);

  final String word1, word2;

  int getLetterCount() => word1.length;
}

class Anagram extends StatefulWidget {
  Anagram(this.word);

  final AnagramData word;

  @override
  _AnagramState createState() => new _AnagramState();
}

class _AnagramState extends State<Anagram> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Finde das Anagram'),
        ),
        body: new Padding(
          padding: new EdgeInsets.symmetric(
              vertical: 10.0
          ),
          child: new Column(

            children: <Widget>[
              new LetterCanvas.fromString(widget.word.word1),
              new WordBox(widget.word.getLetterCount()),
              new WordBox(widget.word.getLetterCount())
            ],
            mainAxisAlignment: MainAxisAlignment.end,

          ),

        )
    );
  }
}

class WordBox extends StatefulWidget {

  final int _letterCount;

  WordBox(this._letterCount);

  @override
  _WordBoxState createState() => new _WordBoxState();
}

class _WordBoxState extends State<WordBox> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: new List.generate(widget._letterCount, (int index) {
              return new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new Placeholder(
                  fallbackHeight: 10.0,
                  fallbackWidth: 10.0,
                ),
                constraints: new BoxConstraints(
                    minHeight: 40.0, minWidth: 40.0),
              );
            }))
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, index) {

        },
      itemCount: widget._letters.length,
    );
  }
}



