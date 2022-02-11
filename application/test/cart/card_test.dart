import 'package:application/application.dart';
import 'package:flutter_test/flutter_test.dart';

import '../dependencies.dart';
import 'add_product_to_cart.dart';
import 'closed_cart.dart';

void main() {
  dependenciesInjection();
  Application.registerHandles();
  group('cart', () {
    test('Test add product to cart', addProductsToCartTest);
    test('Test to close cart', closeCartTest);
  });
}
