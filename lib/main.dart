import 'package:flutter/material.dart';
import 'package:flutter_app/LetterCanvas.dart';
import 'package:flutter_app/WordBox.dart';

void main() {
  return runApp(
      new MaterialApp(
        title: 'AnnAgram',
        home: new Anagram(new AnagramData(['Ampel', 'Lampe'], 5)),
        theme: new ThemeData(primaryColor: Colors.amberAccent)
      )
  );
}

class AnagramData {
  //TODO: Fix case sensitivity!
  AnagramData(this.words, this.letterCount){
    assert(words.length >= 2);
    assert(words.every((word) => word.length == letterCount));
  }

  final int letterCount;
  final List<String> words;

  int getLetterCount() => letterCount;
  int getNumberOfWords() => words.length;

  bool containsWord(String word)=> words.contains(word);
}

class Anagram extends StatefulWidget {
  Anagram(this.anagram);

  final AnagramData anagram;

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
                child: new LetterCanvas(widget.anagram.words[0], (content, color){
                  debugPrint(new String.fromCharCode(content) + ' Pressed');
                  _addToSelection(new String.fromCharCode(content).toUpperCase(), color);
                }),
                  key: new ObjectKey(widget.anagram.words[0]),
              )

            ]..addAll(new List<Widget>.generate(widget.anagram.words.length, (index){
              debugPrint('Wordbox added!');
              return new WordBox.fullEntry(widget.anagram.getLetterCount(), _currentSelection);
            })),

          ),

        )
    );
  }
}






