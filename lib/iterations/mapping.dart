import 'AssertValue.dart';

Iterable<String> getNameAndAges(Iterable<User> users) {
  return users.map((e) => '${e.name} is ${e.age}');
}

class User {
  String name;
  int age;

  User(
    this.name,
    this.age,
  );
}

var users = [
  User('Alice', 21),
  User('Bob', 17),
  User('Claire', 52),
];

void main() {
  try {
    final out = getNameAndAges(users).toList();
    if (out == null) {
      result(false, [
        'Tried running `getNameAndAges`, but received a null value. Did you implement the method?'
      ]);
      return;
    }
    if (!_listEquals(out, ['Alice is 21', 'Bob is 17', 'Claire is 52'])) {
      result(false, ['Looks like `getNameAndAges` is wrong. Keep trying! The output was $out']);
      return;
    }
    result(true);
  } catch (e) {
    result(false, ['Tried running the method, but received an exception: $e']);
  }
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a == null)
    return b == null;
  if (b == null || a.length != b.length)
    return false;
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index])
      return false;
  }
  return true;
}

