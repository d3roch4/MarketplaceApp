import 'dart:math';

import 'package:application/repository/RepositoryBase.dart';
import 'package:domain/entities/Entity.dart';

class RepositoryBaseMemory<T extends Entity> implements IRepositoryBase<T>{
  List<T> memory = [];

  @override
  Future<String> add(T entity) async {
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
