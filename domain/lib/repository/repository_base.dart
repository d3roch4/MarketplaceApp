import 'dart:async';

import 'package:domain/entities/entity.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class RepositoryBase<T extends Entity> {
  DomainEventService eventService;

  RepositoryBase(this.eventService);

  Future<T?> getById(String id);
  Future<String> create(T entity);
  Future<void> update(T entity);

  Future<void> save(T entity) async {
    if (entity.id == null) {
      var id = await create(entity);
      entity.id = id;
    } else {
      await update(entity);
    }
    await eventService.callAll(entity.domainEvents);
  }
}
