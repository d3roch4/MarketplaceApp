import 'package:application/cart/AddProductToCart.dart';
import 'package:application/repository/ProductRepository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/Cart.dart';
import 'package:domain/entities/Money.dart';
import 'package:domain/entities/Product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Future<Cart> addProductsToCartTest() async {
  var repo = Get.find<ProductRepository>();
  repo.add(
    Product(name: 'name', storeId: 'storeId', description: 'description')
    ..id='productId'
    ..stockCount=10
  );
  var cmd = AddProductToCartCommand('productId', 2);
  await Mediator.instance.run(cmd) as Cart;
  cmd = AddProductToCartCommand('productId', 2);
  await Mediator.instance.run(cmd) as Cart;
  cmd = AddProductToCartCommand('productId', 2);
  var cart = await Mediator.instance.run(cmd) as Cart;

  expect(cart.products.length, 1);
  return cart;
}
