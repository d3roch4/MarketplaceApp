import 'dart:math';

import 'package:application/repository/CartRepository.dart';
import 'package:domain/entities/User.dart';
import 'package:domain/entities/Cart.dart';
import 'package:infra/repository/memory/RepositoryBaseMemory.dart';

class CartRepositoryMemory extends CartRepository {
  var memory = RepositoryBaseMemory<Cart>();

  @override
  Future<Cart?> findOpenedByUser(User user) async {
    var result = memory.memory.where((e) => e.buyerId == user.id && e.status == CartStatus.opened);
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
