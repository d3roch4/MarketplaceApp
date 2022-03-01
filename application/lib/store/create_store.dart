import 'package:application/repository/store_repository.dart';
import 'package:application/services/marketplace_manager_service.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/employee.dart';
import 'package:domain/entities/store.dart';

class CreateStoreCommand extends IAsyncCommand {
  String name = '';
  String email = '';
}

class CreateStoreHandle extends IAsyncCommandHandler<CreateStoreCommand> {
  StoreRepository storeRepository;
  MarketplaceManagerService marketplaceManager;
  UserManagerService userManager;

  CreateStoreHandle(this.storeRepository, this.marketplaceManager, this.userManager);

  @override
  Future call(CreateStoreCommand command) async {
    if (command.name.isEmpty)
      throw ArgumentError('The name ir required', 'name');
    if (command.email.isEmpty)
      throw ArgumentError('The email ir required', 'email');
    var user = await userManager.loadUser();
    if(user?.id == null) throw AssertionError('Current user is null');
    var marketplace = await marketplaceManager.currentMarketplace();
    if(marketplace?.id == null) throw AssertionError('Current marketplace is null');

    var store = Store(
        name: command.name,
        marketplaceId: marketplace!.id!,
        emailToNotifications: command.email,
        employees: [Employee(
          userId: user!.id!,
          type: EmployeeType.owner
        )]);
    return await storeRepository.save(store);
  }
}
