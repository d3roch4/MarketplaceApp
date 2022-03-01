import 'package:domain/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:infra/repository/memory/repository_base_memory.dart';

class StoreRepositoryMemory extends RepositoryBaseMemory<Store>
    implements StoreRepository {
  StoreRepositoryMemory(DomainEventService eventService) : super(eventService);

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
