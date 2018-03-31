import 'package:flutter_app/HashAlgorithms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test compressString with a to l', () {
    expect(compressString('abcd'), 75280);
  });

  test('Test compressString ignores capitalization', () {
    expect(compressString('AnAn'), compressString('aNan'));
  });
}