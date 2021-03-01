import 'Component.dart';

class Color {
  int red;
  int green;
  int blue;

  Color(this.red, this.green, this.blue);

  Color.black()
      : red = 0,
        green = 0,
        blue = 0;
}

void main() {
  final errs = <String>[];

  try {
    final result = Color.black();

    if (result == null) {
      errs.add('Called Color.black() and got a null in response.');
    } else {
      if (result.red != 0) {
        errs.add(
            'Called Color.black() and got a Color with red equal to ${result.red} instead of the expected value (0).');
      }

      if (result.green != 0) {
        errs.add(
            'Called Color.black() and got a Color with green equal to ${result.green} instead of the expected value (0).');
      }

      if (result.blue != 0) {
        errs.add(
            'Called Color.black() and got a Color with blue equal to ${result.blue} instead of the expected value (0).');
      }
    }
  } catch (e) {
    Component.result(false, [
      'Called Color.black() and got an exception of type ${e.runtimeType}.'
    ]);
    return;
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}
