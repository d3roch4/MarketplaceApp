import 'dart:async';

import 'package:domain/repository/order_repository.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:domain/entities/order.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:get/get.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class OrderRepositoryMemory extends OrderRepository {
  var wrapperd = RepositoryBaseMemory<Order>(Get.find());

  OrderRepositoryMemory(DomainEventService eventService) : super(eventService);

  @override
  Future<String> addOrder(Order entity) async {
    var repoProducts = Get.find<ProductRepository>();
    for (var pc in entity.products) {
      var produto = await repoProducts.getById(pc.productId);
      var stockCount = produto?.stockCount;
      if (stockCount != null) {
        stockCount -= pc.count;
        if (stockCount < 0)
          throw AssertionError('stockCount is less than coun');
        produto?.stockCount = stockCount;
      }
    }
    return wrapperd.create(entity);
  }

  @override
  Future<Order> getByCartId(String id) async {
    return wrapperd.memory.firstWhere((element) => element.cartId == id);
  }

  @override
  Future<Order?> getById(String id) {
    return wrapperd.getById(id);
  }

  @override
  Future<void> update(Order entity) {
    return wrapperd.update(entity);
  }
}
