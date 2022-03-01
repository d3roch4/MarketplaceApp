import 'package:application/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:domain/entities/user.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class StoreRepositoryMemory extends RepositoryBaseMemory<Store> implements StoreRepository{
  @override
  Future<List<Store>> getStoresByUser(User current) {
    // TODO: implement getStoresByUser
    throw UnimplementedError();
  }

  @override
  Stream<List<Store>> getStoresByUserStream(User current) {
    // TODO: implement getStoresByUserStream
    throw UnimplementedError();
  }
}
