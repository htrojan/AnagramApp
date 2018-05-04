import 'package:flutter/material.dart';
import 'package:AnnagramApp/anagram.dart';
import 'package:AnnagramApp/letter_box.dart';
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

              home: new AnagramWidget(
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
