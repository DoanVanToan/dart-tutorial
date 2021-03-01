main() {
  var numbers = [1, 3, -2, 0, 4, 5, 0, 1, 2];
  var numbersUtilZero = numbers.takeWhile((value) => value != 0);
  print('Numbers utils 0: $numbersUtilZero');

  var numbersAfterZero = numbers.skipWhile((value) => value != 0);
  print('Number after 0: $numbersAfterZero');
}
