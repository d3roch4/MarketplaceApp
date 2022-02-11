import 'dart:async';

import 'package:application/repository/OrderRepository.dart';
import 'package:application/repository/ProductRepository.dart';
import 'package:domain/entities/Order.dart';
import 'package:get/get.dart';
import 'package:infra/repository/memory/RepositoryBaseMemory.dart';

class OrderRepositoryMemory extends OrderRepository {
  var wrapperd = RepositoryBaseMemory<Order>();

  @override
  FutureOr<String> addOrder(Order entity) async {
    var repoProducts = Get.find<ProductRepository>();
    for (var pc in entity.products) {
      var produto = await repoProducts.getById(pc.productId);
      produto!.stockCount -= pc.count;
      if (produto.stockCount < 0)
        throw AssertionError('stockCount is less than coun');
    }
    return wrapperd.add(entity);
  }

  @override
  FutureOr<Order> getByCartId(String id) async {
    return wrapperd.memory.firstWhere((element) => element.cartId == id);
  }

  @override
  FutureOr<Order?> getById(String id) {
    return wrapperd.getById(id);
  }

  @override
  FutureOr<void> update(Order entity) {
    return wrapperd.update(entity);
  }
}
