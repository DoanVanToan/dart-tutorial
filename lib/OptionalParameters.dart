import 'Component.dart';

String joinWithCommas(int a, [int b, int c, int d, int e]) {
  List<int> result = [];
  result.add(a);
  if (b != null) result.add(b);
  if (c != null) result.add(c);
  if (d != null) result.add(d);
  if (e != null) result.add(e);
  return result.join(',');
}

void main() {
  final errs = <String>[];

  try {
    final value = joinWithCommas(1);

    if (value != '1') {
      errs.add(
          'Tried calling joinWithCommas(1) and got $value instead of the expected (\'1\').');
    }
  } catch (e) {
    Component.result(false, [
      'Tried calling joinWithCommas(1), but '
          'encountered an exception: ${e.runtimeType}.'
    ]);
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3);

    if (value != '1,2,3') {
      errs.add(
          'Tried calling joinWithCommas(1, 2, 3) and got $value instead of the expected (\'1,2,3\').');
    }
  } catch (e) {
    Component.result(false, [
      'Tried calling joinWithCommas(1, 2 ,3), but encountered an exception: ${e.runtimeType}.'
    ]);
    return;
  }

  try {
    final value = joinWithCommas(1, 2, 3, 4, 5);

    if (value != '1,2,3,4,5') {
      errs.add(
          'Tried calling joinWithCommas(1, 2, 3, 4, 5) and got $value instead of the expected (\'1,2,3,4,5\').');
    }
  } catch (e) {
    Component.result(false, [
      'Tried calling stringify(1, 2, 3, 4 ,5), but encountered an exception: ${e.runtimeType}.'
    ]);
    return;
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}
