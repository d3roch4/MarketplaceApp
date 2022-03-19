import 'dart:math';

import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/entity.dart';
import 'package:domain/services/domain_event_service.dart';

class RepositoryBaseMemory<T extends Entity> extends RepositoryBase<T> {
  List<T> memory = [];

  RepositoryBaseMemory(DomainEventService eventService) : super(eventService);

  @override
  Future<String> create(T entity) async {
    memory.add(entity);
    return Random().nextInt(9999).toString();
  }

  @override
  Future<T?> getById(String id) async {
    var result = memory.where((e) => e.id == id);
    return result.isEmpty ? null : result.first;
  }

  @override
  Future<void> update(T entity) async {
    var exist = getById(entity.id!);
    if (exist == null) throw Exception('entity not found');
    memory[memory.indexOf(entity)] = entity;
  }
}
