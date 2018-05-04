import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ThemedButton extends StatelessWidget {

  static const List<Color> themedColors = [Colors.yellow, Colors.amber, Colors.red];

  final Color _color;
  final String _text;
  final double fontsize;
  final EdgeInsetsGeometry padding;
  final VoidCallback _onPressed;

  const ThemedButton(
      @required this._onPressed,
      this._color,
      this._text,
      {this.fontsize = 80.0, this.padding = const EdgeInsets.all(0.0)}
      );


  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: this.padding,
      child: new GestureDetector(
        onTap: _onPressed,
        child: new Container(
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
        ),
      ),
    );
  }
}
