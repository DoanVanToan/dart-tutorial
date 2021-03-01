import 'Component.dart';

class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  // Create a constructor with an initializer list here:
  FirstTwoLetters(String word)
      : assert(word.length < 2),
        letterOne = word[0],
        letterTwo = word[1];
}

void main() {
  final errs = <String>[];

  try {
    final result = FirstTwoLetters('My String');

    if (result == null) {
      errs.add('Called FirstTwoLetters(\'My String\') and got a null in response.');
    } else {
      if (result.letterOne != 'M') {
        errs.add('Called FirstTwoLetters(\'My String\') and got an object with letterOne equal to \'${result.letterOne}\' instead of the expected value (\'M\').');
      }

      if (result.letterTwo != 'y') {
        errs.add('Called FirstTwoLetters(\'My String\') and got an object with letterTwo equal to \'${result.letterTwo}\' instead of the expected value (\'y\').');
      }
    }
  } catch (e) {
    errs.add('Called FirstTwoLetters(\'My String\') and got an exception of type ${e.runtimeType}.');
  }

  bool caughtException = false;

  try {
    FirstTwoLetters('');
  } catch (e) {
    caughtException = true;
  }

  if (!caughtException) {
    errs.add('Called FirstTwoLetters(\'\') and didn\'t get an exception from the failed assertion.');
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}

