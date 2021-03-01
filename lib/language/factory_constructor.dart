import 'Component.dart';

class Square extends Shape {}

class Circle extends Shape {}

class Shape {
  Shape();

  factory Shape.fromType(String typeName) {
    if (typeName == 'square') return Square();
    if (typeName == 'circle') return Circle();

    print('I do not recognize $typeName');
    return null;
  }
}

class IntegerHolder {
  IntegerHolder();

  // Implement this factory constructor.
  factory IntegerHolder.fromList(List<int> list) {
    int length = list.length;
    switch (length) {
      case 1:
        return IntegerSingle(list[0]);
      case 2:
        return IntegerDouble(list[0], list[1]);
      case 3:
        return IntegerTriple(list[0], list[1], list[2]);
      default:
        return null;
    }
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;

  IntegerSingle(this.a);
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;

  IntegerDouble(this.a, this.b);
}

class IntegerTriple extends IntegerHolder {
  final int a;
  final int b;
  final int c;

  IntegerTriple(this.a, this.b, this.c);
}

void main() {
  final errs = <String>[];

  try {
    final obj = IntegerHolder.fromList([]);

    if (obj != null) {
      errs.add('Called IntegerSingle.fromList([]) and didn\'t get a null.');
    }
  } catch (e) {
    Component.result(false, ['Called IntegerSingle.fromList([]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  try {
    final obj = IntegerHolder.fromList([1]);

    if (obj == null) {
      errs.add('Called IntegerHolder.fromList([1]) and got a null.');
    } else if (obj is! IntegerSingle) {
      errs.add('Called IntegerHolder.fromList([1]) and got an object of type ${obj.runtimeType} instead of IntegerSingle.');
    } else {
      if ((obj as IntegerSingle).a != 1) {
        errs.add('Called IntegerHolder.fromList([1]) and got an IntegerSingle with an \'a\' value of ${(obj as IntegerSingle).a} instead of the expected (1).');
      }
    }
  } catch (e) {
    Component.result(false, ['Called IntegerHolder.fromList([]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  try {
    final obj = IntegerHolder.fromList([1, 2]);

    if (obj == null) {
      errs.add('Called IntegerHolder.fromList([1, 2]) and got a null.');
    } else if (obj is! IntegerDouble) {
      errs.add('Called IntegerHolder.fromList([1, 2]) and got an object of type ${obj.runtimeType} instead of IntegerDouble.');
    } else {
      if ((obj as IntegerDouble).a != 1) {
        errs.add('Called IntegerHolder.fromList([1, 2]) and got an IntegerDouble with an \'a\' value of ${(obj as IntegerDouble).a} instead of the expected (1).');
      }

      if ((obj as IntegerDouble).b != 2) {
        errs.add('Called IntegerHolder.fromList([1, 2]) and got an IntegerDouble with an \'b\' value of ${(obj as IntegerDouble).b} instead of the expected (2).');
      }
    }
  } catch (e) {
    Component.result(false, ['Called IntegerHolder.fromList([1, 2]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  try {
    final obj = IntegerHolder.fromList([1, 2, 3]);

    if (obj == null) {
      errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got a null.');
    } else if (obj is! IntegerTriple) {
      errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an object of type ${obj.runtimeType} instead of IntegerTriple.');
    } else {
      if ((obj as IntegerTriple).a != 1) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${(obj as IntegerTriple).a} instead of the expected (1).');
      }

      if ((obj as IntegerTriple).b != 2) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${(obj as IntegerTriple).b} instead of the expected (2).');
      }

      if ((obj as IntegerTriple).c != 3) {
        errs.add('Called IntegerHolder.fromList([1, 2, 3]) and got an IntegerTriple with an \'a\' value of ${(obj as IntegerTriple).b} instead of the expected (2).');
      }
    }
  } catch (e) {
    Component.result(false, ['Called IntegerHolder.fromList([1, 2, 3]) and got an exception of type ${e.runtimeType}.']);
    return;
  }

  if (errs.isEmpty) {
    Component.result(true);
  } else {
    Component.result(false, errs);
  }
}

