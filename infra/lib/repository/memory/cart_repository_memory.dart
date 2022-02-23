import 'dart:math';

import 'package:application/repository/cart_repository.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/entities/cart.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class CartRepositoryMemory extends CartRepository {
  var memory = RepositoryBaseMemory<Cart>();

  @override
  Future<Cart?> findOpenedByUser(User user) async {
    var result = memory.memory
        .where((e) => e.buyerId == user.id && e.status == CartStatus.opened);
    return result.isEmpty ? null : result.first;
  }

  @override
  Future<String> add(Cart entity) {
    entity.id = Random().nextInt(987654321).toString();
    return memory.add(entity);
  }

  @override
  Future<Cart?> getById(String id) {
    return memory.getById(id);
  }

  @override
  Future update(Cart entity) {
    return memory.update(entity);
  }
}
