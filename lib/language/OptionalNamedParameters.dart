import 'Component.dart';

class MyDataObject {
  final int anInt;
  final String aString;
  final double aDouble;

  MyDataObject({
    this.anInt = 1,
    this.aString = 'Old!',
    this.aDouble = 2.0,
  });

  MyDataObject copyWith({int newInt, String newString, double newDouble}) {
    return MyDataObject(
        anInt: newInt ?? anInt,
        aString: newString ?? aString,
        aDouble: newDouble ?? aDouble);
  }
// Add your copyWith method here:
}

void main() {
  final source = MyDataObject();
  final errs = <String>[];

  try {
    final copy = source.copyWith(newInt: 12, newString: 'New!', newDouble: 3.0);

    if (copy == null) {
      errs.add(
          'Tried copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0) and it returned null');
    } else {
      if (copy.anInt != 12) {
        errs.add(
            'Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s anInt was ${copy.anInt} rather than the expected value (12).');
      }

      if (copy.aString != 'New!') {
        errs.add(
            'Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s aString was ${copy.aString} rather than the expected value (\'New!\').');
      }

      if (copy.aDouble != 3) {
        errs.add(
            'Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0), and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (3).');
      }
    }
  } catch (e) {
    Component.result(false, [
      'Called copyWith(newInt: 12, newString: \'New!\', newDouble: 3.0) and got an exception: ${e.runtimeType}'
    ]);
  }

  try {
    final copy = source.copyWith();

    if (copy == null) {
      errs.add('Tried copyWith() and it returned null');
    } else {
      if (copy.anInt != 1) {
        errs.add(
            'Called copyWith(), and the new object\'s anInt was ${copy.anInt} rather than the expected value (1).');
      }

      if (copy.aString != 'Old!') {
        errs.add(
            'Called copyWith(), and the new object\'s aString was ${copy.aString} rather than the expected value (\'Old!\').');
      }

      if (copy.aDouble != 2) {
        errs.add(
            'Called copyWith(), and the new object\'s aDouble was ${copy.aDouble} rather than the expected value (2).');
      }
    }
  } catch (e) {
    Component.result(
        false, ['Called copyWith() and got an exception: ${e.runtimeType}']);
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}
