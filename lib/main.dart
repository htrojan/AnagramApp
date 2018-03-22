import 'package:flutter/material.dart';
import 'package:flutter_app/LetterCanvas.dart';
import 'package:flutter_app/WordBox.dart';

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

//            mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
//            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new Center(child: new LetterCanvas.fromString(widget.word.word1)),
              ),
              new WordBox(widget.word.getLetterCount()),
              new WordBox(widget.word.getLetterCount())
            ],

          ),

        )
    );
  }
}






