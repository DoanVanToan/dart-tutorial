import 'AssertValue.dart';

Iterable<EmailAddress> parseEmailAddresses(Iterable<String> strings) {
  return strings.map((e) => EmailAddress(e));
}

bool anyInvalidEmailAddress(Iterable<EmailAddress> emails) {
  return emails.any((element) => !isValidEmailAddress(element));
}

Iterable<EmailAddress> validEmailAddresses(Iterable<EmailAddress> emails) {
  return emails.where((element) => isValidEmailAddress(element));
}

bool isValidEmailAddress(EmailAddress email) {
  return email.address.contains('@');
}

class EmailAddress {
  String address;

  EmailAddress(this.address);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAddress && address == other.address;

  @override
  int get hashCode => address.hashCode;

  @override
  String toString() {
    return 'EmailAddress{address: $address}';
  }
}

var input = [
  'ali@gmail.com',
  'bobgmail.com',
  'cal@gmail.com',
];

void main() {
  Iterable<EmailAddress> emails;
  try {
    emails = parseEmailAddresses(input);
    if (emails == null) {
      result(false, [
        'Tried running `parseEmailAddresses`, but received a null value. Did you implement the method?'
      ]);
      return;
    }
    if (emails.isEmpty) {
      result(false, [
        'Tried running `parseEmailAddresses`, but received an empty list.'
      ]);
      return;
    }
    if (!_listEquals(emails.toList(), [
      EmailAddress('ali@gmail.com'),
      EmailAddress('bobgmail.com'),
      EmailAddress('cal@gmail.com'),
    ])) {
      result(false, ['Looks like `parseEmailAddresses` is wrong. Keep trying!']);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `parseEmailAddresses`, but received an exception: $e'
    ]);
    return;
  }

  try {
    final out = anyInvalidEmailAddress(emails);
    if (out == null) {
      result(false, [
        'Tried running `anyInvalidEmailAddress`, but received a null value. Did you implement the method?'
      ]);
      return;
    }
    if (!out) {
      result(false, [
        'Looks like `anyInvalidEmailAddress` is wrong. Keep trying! There is at least one invalid address.'
      ]);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running `anyInvalidEmailAddress`, but received an exception: $e'
    ]);
    return;
  }

  try {
    final valid = validEmailAddresses(emails);
    if (valid == null) {
      result(false, [
        'Tried running `validEmailAddresses`, but received a null value. Did you implement the method?'
      ]);
      return;
    }
    if (emails.isEmpty) {
      result(false, [
        'Tried running `validEmailAddresses`, but received an empty list.'
      ]);
      return;
    }
    if (!_listEquals(valid.toList(), [
      EmailAddress('ali@gmail.com'),
      EmailAddress('cal@gmail.com'),
    ])) {
      result(false, ['Looks like `validEmailAddresses` is wrong. Keep trying!']);
      return;
    }
  } catch (e) {
    result(false, [
      'Tried running the `validEmailAddresses`, but received an exception: $e'
    ]);
    return;
  }

  result(true);
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) return false;
  }
  return true;
}

