import 'package:application/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:domain/entities/user.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class StoreRepositoryMemory extends StoreRepository
    with RepositoryBaseMemory<Store> {
  @override
  Future<List<Store>> getByUser(User? current) async {
    return <Store>[];
  }
}
