class AnagramValidationException implements Exception {
  final String message;

  AnagramValidationException([this.message]);

  @override
  String toString() {
    if (message == null)
      return "AnagramValidationException";
    else
      return "AnagramValidationException: " + message;
  }

}