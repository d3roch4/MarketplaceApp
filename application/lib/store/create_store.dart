import 'package:application/repository/store_repository.dart';
import 'package:application/services/marketplace_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/store.dart';

class CreateStoreCommand extends IAsyncCommand {
  String name = '';
  String email = '';
}

class CreateStoreHandle extends IAsyncCommandHandler<CreateStoreCommand> {
  StoreRepository storeRepository;
  MarketplaceManagerService marketplaceManager;

  CreateStoreHandle(this.storeRepository, this.marketplaceManager);

  @override
  Future call(CreateStoreCommand command) async {
    if (command.name.isEmpty)
      throw ArgumentError('The name ir required', 'name');
    if (command.email.isEmpty)
      throw ArgumentError('The email ir required', 'email');
    var store = Store(
        name: command.name,
        marketplaceId: marketplaceManager.current!.id!,
        emailToNotifications: command.email);
    return await storeRepository.save(store);
  }
}
