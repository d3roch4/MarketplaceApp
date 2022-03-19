import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/money.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/repository/product_repository.dart';

class CreateProductCommand extends IAsyncCommand {
  String storeId = "";
  String name = "";
  String description = "";
  Money price= Money(value: 0, currency: Currency.unknown);
}

class CreateProductHandle extends IAsyncCommandHandler<CreateProductCommand> {
  ProductRepository repository;

  CreateProductHandle(this.repository);

  @override
  Future call(CreateProductCommand command) async {
    if (command.storeId.isEmpty) throw ArgumentError("storeId is required");
    await repository.save(Product(
        name: command.name,
        storeId: command.storeId,
        description: command.description));
  }
}
