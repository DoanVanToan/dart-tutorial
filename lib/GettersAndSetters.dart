import 'Component.dart';

class InvalidPriceException {}

class ShoppingCart {
  List<double> _prices = [];

  // Add a "total" getter here:
  double get total {
    var total = 0.0;
    _prices.forEach((element) {
      total += element;
    });
    return total;
  }

  // Add a "prices" setter here:
  set prices(List<double> values) {
    if (values.any((element) => element < 0)) throw InvalidPriceException();
    _prices = values;
  }
}

void main() {
  var foundException = false;
  try {
    final cart = ShoppingCart();
    cart.prices = [12.0, 12.0, -23.0];
  } on InvalidPriceException {
    foundException = true;
  } catch (e) {
    Component.result(false, ['Tried setting a negative price and received a '
        '${e.runtimeType} instead of an InvalidPriceException.']);
    return;
  }

  if (!foundException) {
    Component.result(false, [
      'Tried setting a negative price and didn\'t get an InvalidPriceException.'
    ]);
    return;
  }

  final secondCart = ShoppingCart();

  try {
    secondCart.prices = [1.0, 2.0, 3.0];
  } catch (e) {
    Component.result(false, ['Tried setting prices with a valid list, but received an exception: ${e.runtimeType}.']);
    return;
  }

  if (secondCart._prices == null) {
    Component.result(false, ['Tried setting prices with a list of three values, but _prices ended up being null.']);
    return;
  }

  if (secondCart._prices.length != 3) {
    Component.result(false, ['Tried setting prices with a list of three values, but _prices ended up having length ${secondCart._prices.length}.']);
    return;
  }

  if (secondCart._prices[0] != 1.0 ||
      secondCart._prices[1] != 2.0 ||
      secondCart._prices[2] != 3.0) {
    final vals = secondCart._prices.map((p) => p.toString()).join(', ');
    Component.result(false, [
      'Tried setting prices with a list of three values (1, 2, 3), but incorrect ones ended up in the price list ($vals) .'
    ]);
    return;
  }

  var sum = 0.0;

  try {
    sum = secondCart.total;
  } catch (e) {
    Component.result(false,
        ['Tried to get total, but received an exception: ${e.runtimeType}.']);
    return;
  }

  if (sum != 6.0) {
    Component.result(false, [
      'After setting prices to (1, 2, 3), total returned $sum instead of 6.'
    ]);
    return;
  }

  // Component.result(true);
}
