import 'package:flutter/material.dart';
import 'package:flutter_app/LetterCanvas.dart';
import 'package:flutter_app/WordBox.dart';

void main() {
  return runApp(
      new MaterialApp(
        title: 'AnnAgram',
        home: new Anagram(new AnagramData('Ampel', 'Lampe')),
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
  List<LetterEntry> _currentSelection;

  @override
  void initState(){
    super.initState();

    _currentSelection = new List();
  }

  void _addToSelection(String s, Color color){
    setState((){
      _currentSelection.add(new LetterEntry(color, s));
    });
  }

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

          mainAxisAlignment: MainAxisAlignment.end,

            children: <Widget>[
              new Expanded(
                child: new LetterCanvas(widget.word.word1, (content, color){
                  debugPrint(new String.fromCharCode(content) + ' Pressed');
                  _addToSelection(new String.fromCharCode(content).toUpperCase(), color);
                }),
                  key: new ObjectKey(widget.word.word1),
              ),
              new WordBox.fullEntry(widget.word.getLetterCount(), _currentSelection),
              new WordBox.fullEntry(widget.word.getLetterCount(), [const LetterEntry(Colors.yellow, 'T')])
            ],

          ),

        )
    );
  }
}






