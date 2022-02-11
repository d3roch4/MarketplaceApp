import 'dart:async';

import 'package:application/services/DomainEventService.dart';
import 'package:domain/entities/Entity.dart';

abstract class IRepositoryBase<T extends Entity> {
  FutureOr<T?> getById(String id);
  FutureOr<String> add(T entity);
  FutureOr<void> update(T entity);
}

abstract class RepositoryBase<T extends Entity> implements IRepositoryBase<T>{
  var eventService = DomainEventService();


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
