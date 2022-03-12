import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/money.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/repository/product_repository.dart';

class CreateEditProductCommand extends IAsyncCommand {
  String? id;
  String storeId = "";
  String name = "";
  String description = "";
  Money price = Money(value: 0, currency: Currency.ethereum);
  int? stockCount;
  bool physical = true;
  List<String> media = [];

  void load(Product product) {
    id = product.id;
    storeId = product.storeId;
    name = product.name;
    description = product.description;
    price = product.price;
    stockCount = product.stockCount;
    physical = product.stockCheck;
    media = product.media;
  }
}

class CreateEditProductHandle
    extends IAsyncCommandHandler<CreateEditProductCommand> {
  ProductRepository repository;

  CreateEditProductHandle(this.repository);

  @override
  Future call(CreateEditProductCommand command) async {
    if (command.storeId.isEmpty) throw ArgumentError("storeId is required");
    await repository.save(Product(
        name: command.name,
        storeId: command.storeId,
        description: command.description,
        media: command.media)
      ..price = command.price
      ..stockCheck = command.physical
      ..stockCount = command.stockCount);
  }
}
