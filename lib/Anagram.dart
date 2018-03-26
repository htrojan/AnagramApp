import 'package:flutter/material.dart';
import 'package:flutter_app/LetterCanvas.dart';
import 'package:flutter_app/WordBox.dart';

class AnagramData {
  ///All letters and words are stored in uppercase internally
  AnagramData(this.words, this.letterCount) {
    assert(words.length >= 2);
    assert(words.every((word) => word.length == letterCount));
    words = words.map((entry) => entry.toUpperCase()).toList();
    debugPrint(words[0]);
  }

  final int letterCount;
  List<String> words;

  int getNumberOfWords() => words.length;

  bool containsWord(String word) => words.contains(word);
}

class Anagram extends StatefulWidget {
  Anagram(this.anagram);

  final AnagramData anagram;

  @override
  _AnagramState createState() => new _AnagramState();
}

class _AnagramState extends State<Anagram> {
  List<LetterEntry> _currentSelection;
  List<List<LetterEntry>> _guessedWords;
  int _guessCounter;
  Key _pageKey = new UniqueKey();

  @override
  void initState() {
    super.initState();
    _guessedWords =
    new List.filled(widget.anagram.getNumberOfWords(), new List());
    _currentSelection = new List();
    _guessCounter = 0;
  }

  void _addToSelection(String s, Color color) {
    setState(() {
      _currentSelection.add(new LetterEntry(color, s));
    });
  }

  void _clearAllSelections() {
    setState(() {
      _currentSelection = new List();
      _pageKey = new UniqueKey();
    });
  }

  void _clearGuessedWords() {
    setState(() {
      _guessedWords =
      new List.filled(widget.anagram.getNumberOfWords(), new List());
    });
  }

  void _clearEverything(){
    _clearGuessedWords();
    _clearAllSelections();
  }

  bool _nextIsLastWord() =>
      _guessCounter + 1 == widget.anagram.getNumberOfWords();

  /// Do only call this method if all letters have been typed!
  void _validateSelection() {
    debugPrint('Validating anagram attempt');
    assert(_currentSelection.length == widget.anagram.letterCount);
    final String word = _currentSelection.map((entry) => entry.letter).join();
    debugPrint('Checking for word: ' + word);

    if (widget.anagram.containsWord(word)) {
      debugPrint('Anagram valid');
      setState(() {
        if (_nextIsLastWord()) {
          debugPrint('Riddle solved!');
          _clearGuessedWords();
        } else {
          _guessedWords[_guessCounter] = _currentSelection;
        }

        _guessCounter++;
        _clearAllSelections();
      });
    }
    else {
      debugPrint('Anagram wrong');
      _clearAllSelections();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Finde das Anagram'),
          actions: <Widget>[
            new IconButton(
                onPressed: _clearEverything,
                icon:  new Icon(Icons.refresh),
                iconSize: 50.0,
            )
          ],
        ),
        body: new Padding(
          padding: new EdgeInsets.symmetric(
              vertical: 10.0
          ),
          child: new Column(

            mainAxisAlignment: MainAxisAlignment.end,

            children: <Widget>[
              new Expanded(
                child: new LetterCanvas(
                  widget.anagram.words[0], (content, color) {
                  debugPrint(new String.fromCharCode(content) + ' Pressed');
                  _addToSelection(
                      new String.fromCharCode(content).toUpperCase(), color);
                  //Now check for
                  if (_currentSelection.length == widget.anagram.letterCount)
                    _validateSelection();
                },
                  key: _pageKey,),
              )
            ]
              ..addAll(new List<Widget>.generate(
                  widget.anagram.words.length, (index) {
                return (index == 0) ?
                new WordBox.fullEntry(
                    widget.anagram.letterCount, _currentSelection) :
                new WordBox.fullEntry(
                    widget.anagram.letterCount, _guessedWords[index - 1]);
              })),
          ),
        )
    );
  }
}
