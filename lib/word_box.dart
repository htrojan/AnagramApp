import 'package:flutter/material.dart';
import 'package:AnnagramApp/letter_box.dart';

class LetterEntry {
  final Color color;
  final String letter;

  const LetterEntry(this.color, this.letter);
}

class WordBox extends StatelessWidget {
  final int _letterCount;
  final List<LetterEntry> _content;

  WordBox(this._letterCount) : _content = [];

  WordBox.fullEntry(this._letterCount, List<LetterEntry> entries)
      : _content = entries;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List.generate(_letterCount, (int index) {
        return new Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new AspectRatio(
              aspectRatio: 1.0,
              child: (_content.length > index)
                  ? new LetterBox(
                _content[index].color,
                _content[index].letter.toUpperCase(),
                fontsize: 50.0,
              )
                  : new Placeholder(),
            ),
          ),
        );
      }),
    );
  }

}

