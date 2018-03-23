import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {


  final Color _color;
  final String _text;
  final double fontsize;

  LetterBox(this._color, this._text, {this.fontsize = 80.0});


  @override
  Widget build(BuildContext context) {
    return new Container(
      constraints: const BoxConstraints.tightFor(
          height: 90.0, width: 90.0),
      decoration: new BoxDecoration(
        border: new Border.all(width: 5.0),
        color: _color,
      ),

      child: new Center(
        child: new Text(
          _text,
          style: new TextStyle(
            fontSize: fontsize,

          ),

        ),
      ),
    );
  }
}
