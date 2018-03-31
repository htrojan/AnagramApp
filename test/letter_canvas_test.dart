import 'package:flutter/material.dart';
import 'package:flutter_app/Anagram.dart';
import 'package:flutter_app/LetterBox.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(

    ///Lettercanvas has to support 12 letters, but no more
    'Test for correct Letter count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        new StatefulBuilder(
          builder: (BuildContext context, StateSetter setter) {
            return new MaterialApp(

              home: new Anagram(
                new AnagramData(
                    ['Ampelasdfaas', 'Lampeasdfaas', 'Palmeasdfaas'], 12),
              ),
            );
          },
        ),
      );

      expect(find
          .byType(LetterBox)
          .evaluate()
          .length, 12);
    },
  );
}
