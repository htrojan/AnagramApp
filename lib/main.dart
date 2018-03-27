import 'package:flutter/material.dart';
import 'package:flutter_app/Anagram.dart';

void main() {
  return runApp(
    new MaterialApp(
        title: 'AnnAgram',
        home: new Anagram(new AnagramData(['Ampel', 'Lampe', 'Palme'], 5)),
        theme: new ThemeData(primaryColor: Colors.amberAccent)),
  );
}
