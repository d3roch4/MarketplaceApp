import 'dart:async';

import 'package:application/services/domain_event_service.dart';
import 'package:domain/entities/entity.dart';

abstract class RepositoryBase<T extends Entity>{
  var eventService = DomainEventService();

  Future<T?> getById(String id);
  Future<String> add(T entity);
  Future<void> update(T entity);

  Future<void> save(T entity) async {
    if (entity.id == null) {
      var id = await add(entity);
      entity.id = id;
    } else {
      await update(entity);
    }
    await eventService.callAll(entity.domainEvents);
  }
}
