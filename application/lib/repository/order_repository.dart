import 'dart:async';

import 'package:application/repository/repository_base.dart';
import 'package:domain/entities/order.dart';
import 'package:domain/events/order_create_event.dart';

abstract class OrderRepository extends RepositoryBase<Order> {
  Future<String> addOrder(Order entity);
  Future<Order> getByCartId(String id);

  @override
  Future<String> add(Order entity) async {
    var id = await addOrder(entity);
    entity.domainEvents.add(OrderCreateEvent(id));
    return id;
  }
}
