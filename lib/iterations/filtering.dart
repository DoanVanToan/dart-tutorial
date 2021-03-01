main() {
  var evenNumbers = [1, -2, 3, 42].where((number) => number.isEven);
  for (var number in evenNumbers) {
    print(number);
  }
  if (evenNumbers.any((element) => element.isNegative)) {
    print('evenNumbers contains negative number');
  }
  var largeNumbers = evenNumbers.where((number) => number > 1000);
  if (largeNumbers.isEmpty) {
    print('largeNumbers is empty');
  }
}
