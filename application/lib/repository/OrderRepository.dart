import 'dart:async';

import 'package:application/repository/RepositoryBase.dart';
import 'package:domain/entities/Order.dart';
import 'package:domain/events/OrderCreateEvent.dart';

abstract class OrderRepository extends RepositoryBase<Order> {
  FutureOr<String> addOrder(Order entity);
  FutureOr<Order> getByCartId(String id);

  @override
  FutureOr<String> add(Order entity) async {
    var id = await addOrder(entity);
    entity.domainEvents.add(OrderCreateEvent(id));
    return id;
  }
}
