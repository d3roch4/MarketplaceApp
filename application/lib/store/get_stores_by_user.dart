import 'package:application/repository/store_repository.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/store.dart';

class GetStoresByUserQuery extends IAsyncQuery<List<Store>> {}

class GetStoresByUserHandle
    extends IAsyncQueryHandler<List<Store>, GetStoresByUserQuery> {
  StoreRepository storesRepo;
  UserManagerService userManager;

  GetStoresByUserHandle(this.storesRepo, this.userManager);

  @override
  Future<List<Store>> call(GetStoresByUserQuery command) async {
    if (userManager.current == null)
      throw AssertionError('Current user is null');
    return storesRepo.getByUser(userManager.current!);
  }
}
