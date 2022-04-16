import 'dart:math';

import 'package:domain/model/cart_stores_products.dart';
import 'package:domain/repository/cart_repository.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class CartRepositoryMemory extends CartRepository {
  late RepositoryBaseMemory<Cart> memory;

  CartRepositoryMemory(DomainEventService eventService) : super(eventService) {
    memory = RepositoryBaseMemory<Cart>(eventService);
  }

  @override
  Future<Cart?> findOpenedByUser(User user) async {
    var result = memory.memory
        .where((e) => e.buyerId == user.id && e.status == CartStatus.opened);
    return result.isEmpty ? null : result.first;
  }

  @override
  Future<String> create(Cart entity) {
    entity.id = Random().nextInt(987654321).toString();
    return memory.create(entity);
  }

  @override
  Future<Cart?> getById(String id) {
    return memory.getById(id);
  }

  @override
  Future update(Cart entity) {
    return memory.update(entity);
  }

  @override
  Future<CartStoresProducts> getCartStoresProductsByCart(String cartId) {
    // TODO: implement getCartStoresProductsByCart
    throw UnimplementedError();
  }

  @override
  Future<List<Cart>> getCartsByBuyer(String buyerId) {
    // TODO: implement getCartsByBuyer
    throw UnimplementedError();
  }
}
