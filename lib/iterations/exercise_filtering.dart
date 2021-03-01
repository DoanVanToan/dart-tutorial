import 'AssertValue.dart';

Iterable<User> filterUnder21(Iterable<User> users) {
  return users.where((element) => element.age >= 21);
}

Iterable<User> findShortNamed(Iterable<User> users) {
  return users.where((element) => element.name.length <= 3);
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
  User('Dan', 12),
];

void main() {
  try {
    var out = filterUnder21(users);
    if (out.any((user) => user.age < 21) || out.length != 2) {
      result(false, ['Looks like `filterUnder21` is wrong, there are exactly two users with age under 21. Keep trying!']);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `filterUnder21`, but received an exception: ${e.runtimeType}'
    ]);
    return;
  }

  try {
    var out = findShortNamed(users);
    if (out.any((user) => user.name.length > 3) || out.length != 2) {
      result(false, ['Looks like `findShortNamed` is wrong, there are exactly two users with a three letter name. Keep trying!']);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `findShortNamed`, but received an exception: ${e.runtimeType}'
    ]);
    return;
  }

  result(true);
}

