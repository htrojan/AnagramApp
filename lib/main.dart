import 'package:flutter/material.dart';
import 'package:AnnagramApp/main_menu.dart';
import 'package:AnnagramApp/anagram.dart';

void main() {
  return runApp(
    new MaterialApp(
        title: 'AnnAgram',
//        home: new Anagram(new AnagramData(['Ampel', 'Lampe', 'Palme'], 5)),
        home: new MainMenu(),
        theme: new ThemeData(primaryColor: Colors.amberAccent)),
  );
}
