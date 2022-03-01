import 'package:application/repository/store_repository.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/store.dart';

class GetStoresByUserQuery extends IQuery<Stream<List<Store>>> {}

class GetStoresByUserHandle
    extends IQueryHandler<Stream<List<Store>>, GetStoresByUserQuery> {
  StoreRepository storesRepo;
  UserManagerService userManager;

  GetStoresByUserHandle(this.storesRepo, this.userManager);

  @override
  Stream<List<Store>> call(GetStoresByUserQuery command) async* {
    if (await userManager.loadUser() == null)
      throw AssertionError('Current user is null');
    yield* storesRepo.getStoresByUserStream(userManager.current!);
  }
}
