import 'dart:async';
import 'dart:io';

import 'package:AnnagramApp/anagram.dart';
import 'package:AnnagramApp/themed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MainMenu extends StatelessWidget {
  MainMenu();

  MainMenu.forDesignTime();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('AnnAgram - Hauptmenü'),
      ),
      body: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ThemedButton(
              () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AnagramWidget(
                            AnagramData(["Lampe", "Ampel"], 5))));
              },
              ThemedButton.themedColors[0],
              "Starten",
              fontsize: 50.0,
              padding: const EdgeInsets.all(2.0),
            ),
            ThemedButton(
              () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ChooseWidget()));
              },
              ThemedButton.themedColors[1],
              "Auswählen",
              fontsize: 50.0,
              padding: const EdgeInsets.all(2.0),
            ),
            ThemedButton(
              () {},
              ThemedButton.themedColors[2],
              "Test",
              padding: const EdgeInsets.all(2.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChooseWidgetState();
  }
}

class ChooseWidgetState extends State<ChooseWidget> {
  static const platform = const MethodChannel('annagram/filePermissions');

  ChooseWidget() {
    debugPrint("ChooseWidget created!");
  }

  Future<Directory> get _localDir async {
    final directory = await getExternalStorageDirectory();
    return directory;
  }

  Future<List<File>> get _anagramFiles async {
      var result = await platform.invokeMethod('getFileAccess');
//      print("Result = " + result);

    print("Entering _anagramFiles");
    final dir = await _localDir;

    print(dir == null);
    List<File> _list = new List();

    var lister = dir.list(recursive: false);
    print("Listing done!");
    lister.listen(((file) {
      if (file is File)
        _list.add(file);
      else
        print("Not a file!");
    }));
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Auswählen"),
      ),
      body: new FutureBuilder<List<File>>(
        future: _anagramFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (buildContext, index) {
                  return new Text(snapshot.data[index].path);
                },
              );
            default:
              debugPrint("Waiting...");
              return new Text("Waiting...");
          }
        },
      ),
    );
    /** return new FutureBuilder<List<File>>(
        future: _anagramFiles,
        builder: (context, snapshot) {
        switch (snapshot.connectionState) {
        case ConnectionState.done:
        return new ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (buildContext, index) {
        return new Text(snapshot.data[index].path);
        },
        );
        default:
        new Text("Waiting...");
        }
        },
        );**/
  }
}
