import 'package:application/repository/cart_repository.dart';
import 'package:application/repository/order_repository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/order.dart';
import 'package:domain/events/cart_closed_event.dart';

import 'domain_event_notification.dart';

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
