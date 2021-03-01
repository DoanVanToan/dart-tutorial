bool predicate(String element) {
  return element.length > 5;
}

void main() {
  var items = ['Salad', 'Popcorn', 'Toast'];

  var element1 = items.firstWhere((element) => element.length > 5);
  print(element1);

  var element2 = items.firstWhere((element) {
    return element.length > 5;
  });
  print(element2);

  var element3 = items.firstWhere(predicate);
  print(element3);

  var element4 =
      items.firstWhere((element) => element.length > 10, orElse: () => 'None');
  print(element4);
}
