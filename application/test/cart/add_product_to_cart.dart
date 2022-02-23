import 'package:application/cart/add_product_to_cart.dart';
import 'package:application/repository/product_repository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/entities/Money.dart';
import 'package:domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Future<Cart> addProductsToCartTest() async {
  var repo = Get.find<ProductRepository>();
  repo.add(Product(name: 'name', storeId: 'storeId', description: 'description')
    ..id = 'productId'
    ..stockCount = 10);
  var cmd = AddProductToCartCommand('productId', 2);
  await Mediator.instance.run(cmd) as Cart;
  cmd = AddProductToCartCommand('productId', 2);
  await Mediator.instance.run(cmd) as Cart;
  cmd = AddProductToCartCommand('productId', 2);
  var cart = await Mediator.instance.run(cmd) as Cart;

  expect(cart.products.length, 1);
  return cart;
}
