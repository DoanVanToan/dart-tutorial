void result(bool isCorrect, [List<String> message]) {
  if (!isCorrect) {
    throw Exception(message);
  }
}
