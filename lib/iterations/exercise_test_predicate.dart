import 'AssertValue.dart';

// Implement the predicate of singleWhere
// with the following conditions
// * The element contains the character `'a'`
// * The element starts with the character `'M'`
String singleWhere(Iterable<String> items) {
  return items.singleWhere(predicate);
}

bool predicate(String element) {
  return element.contains('a') && element.startsWith('M');
}

var items = [
  'Salad',
  'Popcorn',
  'Milk',
  'Toast',
  'Sugar',
  'Mozzarella',
  'Tomato',
  'Egg',
  'Water',
];

void main() {
  try {
    final str = singleWhere(items);
    if (str == 'Mozzarella') {
      result(true);
    } else if (str == null) {
      result(false, [
        'Tried calling singleWhere, but received a \'null\' value, the result '
            'should be a non-null String'
      ]);
    } else {
      result(false, [
        'Tried calling singleWhere, but received $str instead of the expected '
            'value \'Mozzarella\''
      ]);
    }
  } on StateError catch (stateError) {
    result(false, [
      'Tried calling singleWhere, but received a StateError: ${stateError.message}. '
          'singleWhere will fail if 0 or many elements match the '
          'predicate'
    ]);
  } catch (e) {
    result(false, [
      'Tried calling singleWhere, but received an exception: $e'
    ]);
  }
}

