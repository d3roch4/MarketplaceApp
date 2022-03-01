import 'dart:async';

import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/order.dart';
import 'package:domain/events/order_create_event.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class OrderRepository extends RepositoryBase<Order> {
  OrderRepository(DomainEventService eventService) : super(eventService);

  Future<String> addOrder(Order entity);
  Future<Order> getByCartId(String id);

  @override
  Future<String> add(Order entity) async {
    var id = await addOrder(entity);
    entity.domainEvents.add(OrderCreateEvent(id));
    return id;
  }
}
