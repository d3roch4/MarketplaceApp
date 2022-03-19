import 'package:domain/repository/marketplace_repository.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:get/get.dart';

class CreateMarketplaceCommand extends IAsyncCommand {
  String name;
  String? subDomain;
  List<String> domains = [];

  CreateMarketplaceCommand(
      {required this.name, this.domains = const [], this.subDomain});
}

class CreateMarketplaceHandle
    extends IAsyncCommandHandler<CreateMarketplaceCommand> {
  var userManager = Get.find<UserManagerService>();
  var repository = Get.find<MarketplaceRepository>();

  @override
  Future call(CreateMarketplaceCommand command) async {
    if (userManager.current?.id == null)
      throw AssertionError("Current user is null");
    var marketplace =
        Marketplace(name: command.name, userId: userManager.current!.id!);
    marketplace.domains = command.domains;
    marketplace.subDomain = command.subDomain;

    await repository.create(marketplace);
  }
}
