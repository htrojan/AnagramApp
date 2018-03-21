import 'package:flutter/material.dart';

class WordBox extends StatefulWidget {
  final int _letterCount;

  WordBox(this._letterCount);

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
                  child: new Placeholder(
                  ),
                ),
              ));
        })
    )
    ;
  }
}
