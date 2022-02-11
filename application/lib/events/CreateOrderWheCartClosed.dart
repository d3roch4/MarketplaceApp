import 'package:application/repository/CartRepository.dart';
import 'package:application/repository/OrderRepository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/Order.dart';
import 'package:domain/events/CartClosedEvent.dart';

import 'DomainEventNotification.dart';

class CreateOrderWheCartClosed
    extends IAsyncCommandHandler<DomainEventNotification<CartClosedEvent>> {
  CartRepository cartRepository;
  OrderRepository orderRepository;

  CreateOrderWheCartClosed(this.cartRepository, this.orderRepository);

  @override
  Future call(DomainEventNotification<CartClosedEvent> command) async {
    var cart = await cartRepository.getById(command.event.cartId);
    if (cart == null) throw ArgumentError("cart not found", "cartId");
    var stores = <String>{};

    for (var produto in cart.products) {
      stores.add(produto.storeId);
    }

    for (var storeId in stores) {
      var order = Order(
          cartId: cart.id!,
          buyerId: cart.buyerId,
          storeId: storeId,
          shippingAddress: cart.shippingAddress,
          products: cart.products.where((p) => p.storeId == storeId).toList());
      await orderRepository.save(order);
    }
  }
}
