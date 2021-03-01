import 'Component.dart';

class MyClass {
  final int anInt;
  final String aString;
  final double aDouble;

  MyClass(this.anInt, this.aString, this.aDouble);
}

void main() {
  final errs = <String>[];

  try {
    final obj = MyClass(1, 'two', 3);

    if (obj == null) {
      errs.add('Called MyClass(1, \'two\', 3) and got a null in response.');
    } else {
      if (obj.anInt != 1) {
        errs.add(
            'Called MyClass(1, \'two\', 3) and got an object with anInt of ${obj.anInt} instead of the expected value (1).');
      }

      if (obj.anInt != 1) {
        errs.add(
            'Called MyClass(1, \'two\', 3) and got an object with aString of \'${obj.aString}\' instead of the expected value (\'two\').');
      }

      if (obj.anInt != 1) {
        errs.add(
            'Called MyClass(1, \'two\', 3) and got an object with aDouble of ${obj.aDouble} instead of the expected value (3).');
      }
    }
  } catch (e) {
    Component.result(false, [
      'Called MyClass(1, \'two\', 3) and got an exception of type ${e.runtimeType}.'
    ]);
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}
