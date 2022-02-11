import 'package:application/repository/CartRepository.dart';
import 'package:application/repository/ProductRepository.dart';
import 'package:application/services/IUserManagerService.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:collection/collection.dart';
import 'package:domain/entities/ChosenProduct.dart';

class AddProductToCartCommand extends IAsyncCommand {
  String productId;
  int count;

  AddProductToCartCommand(this.productId, this.count);
}

class AddProductToCartHandle
    extends IAsyncCommandHandler<AddProductToCartCommand> {
  IUserManagerService userManager;
  CartRepository cartRepository;
  ProductRepository productRepository;

  AddProductToCartHandle(
      this.userManager, this.cartRepository, this.productRepository);

  @override
  Future call(AddProductToCartCommand command) async {
    var user = userManager.currentUser();
    var cart = await cartRepository.getOpenedOrNew(user);
    var product = await productRepository.getById(command.productId);
    if (product == null) throw AssertionError('product not found');
    if (product.stockCount < 1) throw AssertionError('product out of stock');

    var exist =
        cart.products.firstWhereOrNull((p) => p.productId == command.productId);
    if (exist == null) {
      cart.products.add(ChosenProduct(
        productId: command.productId,
        storeId: product.storeId,
        count: command.count,
        price: product.price,
        physical: product.physical,
      ));
    } else {
      exist.count++;
    }

    await cartRepository.save(cart);
    return cart;
  }
}
