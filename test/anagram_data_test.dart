import 'package:flutter_app/Anagram.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AnagramData Accepting no variable length of words', () {
    expect(() => new AnagramData(['Ampel', 'Palm'], 5), throwsAssertionError);
  });

  test('AnagramData accepting no words with different letters', () {
    expect(() => new AnagramData(['Ampel', 'Busss'], 5), throwsException);
  });
}
