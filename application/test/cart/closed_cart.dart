import 'package:application/cart/add_product_to_cart.dart';
import 'package:application/cart/payment_of_cart.dart';
import 'package:application/repository/cart_repository.dart';
import 'package:application/repository/order_repository.dart';
import 'package:application/repository/product_repository.dart';
import 'package:application/repository/store_repository.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/address.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/entities/store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

Future<void> closeCartTest() async {
  var storeRepo = Get.find<StoreRepository>();
  var store = Store(
      name: 'name',
      marketplaceId: 'marketplaceId',
      emailToNotifications: 'sellers@outher-organization.com',
      id: 'storeId');
  storeRepo.add(store);
  store = Store(
      name: 'name',
      marketplaceId: 'marketplaceId',
      emailToNotifications: 'sellers@organization.com',
      id: 'storeId2');
  storeRepo.add(store);

  var productRepo = Get.find<ProductRepository>();
  productRepo.add(
      Product(name: 'name', storeId: 'storeId2', description: 'description')
        ..id = 'productId2'
        ..stockCount = 10);

  var user = await Get.find<UserManagerService>().loadUser();
  var cart = await Get.find<CartRepository>().getOpenedOrNew(user);
  cart.shippingAddress = Address(
      zipCode: 'zipCode',
      street: 'street',
      city: 'city',
      coutry: 'coutry',
      ditrict: 'ditrict',
      state: 'state',
      latitude: 0,
      longitude: 0);
  await Mediator.instance.run(AddProductToCartCommand('productId2', 2)) as Cart;

  await Mediator.instance.run(PaymentOfCartCommand(cart.id!));

  cart = (await Get.find<CartRepository>().getById(cart.id!))!;
  expect(cart.status, CartStatus.closed);

  var order = await Get.find<OrderRepository>().getByCartId(cart.id!);
  expect(order.cartId, cart.id);

  var product2 = await productRepo.getById('productId2');
  expect(product2!.stockCount, 8);
}
