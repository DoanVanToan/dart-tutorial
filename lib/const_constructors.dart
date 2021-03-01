import 'Component.dart';

class ImmutablePoint {
  const ImmutablePoint(this.x, this.y);

  final int x;
  final int y;
  static const ImmutablePoint origin = ImmutablePoint(0, 0);
}
// Example

class Recipe {
  const Recipe(this.ingredients, this.calories, this.milligramsOfSodium);

  final List<String> ingredients;
  final int calories;
  final double milligramsOfSodium;
}

void main() {
  final errs = <String>[];

  try {
    const obj = Recipe(['1 egg', 'Pat of butter', 'Pinch salt'], 120, 200);

    if (obj == null) {
      errs.add(
          'Tried calling Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and received a null.');
    } else {
      if (obj.ingredients?.length != 3) {
        errs.add(
            'Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with ingredient list of length ${obj.ingredients?.length} rather than the expected length (3).');
      }

      if (obj.calories != 120) {
        errs.add(
            'Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with a calorie value of ${obj.calories} rather than the expected value (120).');
      }

      if (obj.milligramsOfSodium != 200) {
        errs.add(
            'Called Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and got an object with a milligramsOfSodium value of ${obj.milligramsOfSodium} rather than the expected value (200).');
      }
    }
  } catch (e) {
    Component.result(false, [
      'Tried calling Recipe([\'1 egg\', \'Pat of butter\', \'Pinch salt\'], 120, 200) and received a null.'
    ]);
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}
