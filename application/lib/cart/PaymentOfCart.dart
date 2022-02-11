import 'package:application/repository/CartRepository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/Cart.dart';

class PaymentOfCartCommand extends IAsyncCommand {
  String cartId;

  PaymentOfCartCommand(this.cartId);
}

class PaymentOfCartHandle extends IAsyncCommandHandler<PaymentOfCartCommand> {
  CartRepository cartRepository;

  PaymentOfCartHandle(this.cartRepository);

  @override
  Future call(PaymentOfCartCommand command) async {
    var cart = await cartRepository.getById(command.cartId);
    if (cart == null) throw ArgumentError('cart not found', 'cartId');
    if (cart.products.isEmpty) throw ArgumentError('cart is empty', 'cartId');

    cart.status = CartStatus.closed;
    await cartRepository.save(cart);
  }
}
