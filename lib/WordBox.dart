import 'package:flutter/material.dart';
import 'package:flutter_app/LetterBox.dart';

class WordBox extends StatefulWidget {
  final int _letterCount;
  final List<String> _content;

  WordBox(this._letterCount) : _content = [];
  WordBox.withContent(this._letterCount, this._content);

  @override
  _WordBoxState createState() => new _WordBoxState();
}

class _WordBoxState extends State<WordBox> {
  @override
  Widget build(BuildContext context) {
    return new Row(

        mainAxisAlignment: MainAxisAlignment.center,
        children: new List.generate(widget._letterCount, (int index) {
          return new Expanded(

              child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new AspectRatio(
                  aspectRatio: 1.0,
                  child: (widget._content.length > index) ?
                  new LetterBox(Colors.yellow, widget._content[index].toUpperCase(), fontsize: 50.0,) : new Placeholder(),
                ),
              ));
        })
    )
    ;
  }
}
