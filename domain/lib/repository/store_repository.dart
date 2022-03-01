import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/store.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class StoreRepository extends RepositoryBase<Store> {
  StoreRepository(DomainEventService eventService) : super(eventService);

  Future<List<Store>> getStoresByUser(User current);
  Stream<List<Store>> getStoresByUserStream(User current);
}
