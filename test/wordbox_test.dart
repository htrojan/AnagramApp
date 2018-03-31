import 'package:flutter/material.dart';
import 'package:flutter_app/letter_box.dart';
import 'package:flutter_app/word_box.dart';
import 'package:flutter_test/flutter_test.dart';

Widget testWidgetHelper(Widget widget) {
  return new StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return new MaterialApp(home: widget);
    },
  );
}

void main() {
  testWidgets(
    'Test for correct number of Placeholder',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return new MaterialApp(home: new WordBox(20));
          },
        ),
      );

      expect(find.byType(Placeholder).evaluate().length, 20);
    },
  );

  for (int letterCount = 0; letterCount < 10; letterCount++) {
    testWidgets(
      'Test for correct split between filled LetterBoxes and Placeholders letterCount = ' +
          letterCount.toString(),
      (WidgetTester tester) async {
        await tester.pumpWidget(new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return new MaterialApp(
              home: new WordBox.fullEntry(
                10,
                new List.filled(
                  letterCount,
                  const LetterEntry(Colors.orange, 'T'),
                ),
              ),
            );
          },
        ));

        expect(find.byType(Placeholder).evaluate().length, 10 - letterCount);
        expect(find.byType(LetterBox).evaluate().length, letterCount);
      },
    );
  }
}
