import 'AssertValue.dart';

bool anyUserUnder18(Iterable<User> users) {
  return users.any((element) => element.age < 18);
}

bool everyUserOver13(Iterable<User> users) {
  return users.every((element) => element.age > 13);
}

class User {
  String name;
  int age;

  User(this.name, this.age);
}

var users = [
  User('Alice', 21),
  User('Bob', 17),
  User('Claire', 52),
  User('David', 14),
];

void main() {
  try {
    var out = anyUserUnder18(users);
    if (out == null) {
      result(false, [
        'Tried running `anyUserUnder18`, but received a null value. '
            'Did you implement the method?'
      ]);
      return;
    }
    if (!out) {
      result(false, ['Looks like `anyUserUnder18` is wrong. Keep trying!']);
      return;
    }
  } catch (e) {
    result(false,
        ['Tried running `anyUserUnder18`, but received an exception: $e']);
    return;
  }

  try {
    // with only one user older than 18, should be false
    var out = anyUserUnder18([User('Alice', 21)]);
    if (out) {
      result(false, [
        'Looks like `anyUserUnder18` is wrong. What if all users are over 18?'
      ]);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `anyUserUnder18([User("Alice", 21)])`, but received an exception: $e'
    ]);
    return;
  }

  try {
    var out = everyUserOver13(users);
    if (out == null) {
      result(false, [
        'Tried running `everyUserOver13`, but received a null value. '
            'Did you implement the method?'
      ]);
      return;
    }
    if (!out) {
      result(false, [
        'Looks like `everyUserOver13` is wrong. There are no users under 13!'
      ]);
      return;
    }
  } catch (e) {
    result(false,
        ['Tried running `everyUserOver13`, but received an exception: $e']);
    return;
  }

  try {
    var out = everyUserOver13([User('Dan', 12)]);
    if (out) {
      result(false, [
        'Looks like `everyUserOver13` is wrong. There is at least one user under 13!'
      ]);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `everyUserOver13([User(\'Dan\', 12)])`, but received an exception: $e'
    ]);
    return;
  }

  result(true);
}
