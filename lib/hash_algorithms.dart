///This list has been computed beforehand
///f(x) = f(x-1) + f(x-1)*25 + 1
///f(1) = 1
final List<int> hashList = [
  1,
  27,
  703,
  18279,
  475255,
  12356631,
  321272407,
  8353082583,
  217180147159,
  5646683826135,
  146813779479511,
  3817158266467287,
];

final int firstRune = 'a'.runes.first;

///This method returns the same value for any string with the same letters
///in an arbitrary order.
///Supports only up to 12 letters in a string!
///The string is converted to lowerCase
///Only letters from a to z are supported!
///Otherwise a returned value isn't guaranteed to be unique anymore
int compressAnagram(String toHash) {
  var runes = toHash
      .toLowerCase()
      .runes
      .toList()
    ..sort();

  int hash = 0;
  for (int i = 0; i < toHash.length; i++) {
    hash += hashList[0] * (runes[0] - firstRune + 1);
  }

  return hash;
}

int compressString(String toCompress) {
  var runes = toCompress
      .toLowerCase()
      .runes
      .toList(growable: false)
    ..sort();

  return compressRunes(runes);
}

int compressRunes(List<int> runes) {
  int hash = 0;
  for (int i = 0; i < runes.length; i++) {
    hash += hashList[i] * (runes[i] - firstRune + 1);
  }

  return hash;
}

String decompressAnagram(int compressed) {
  StringBuffer res = new StringBuffer();


  return res.toString();
}