import 'package:domain/repository/cart_repository.dart';
import 'package:domain/repository/store_repository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/events/cart_closed_event.dart';

import 'domain_event_notification.dart';

class SendEmailForStoreWheCartClosed
    extends IAsyncCommandHandler<DomainEventNotification<CartClosedEvent>> {
  CartRepository cartRepository;
  StoreRepository storeRepository;

  SendEmailForStoreWheCartClosed(this.cartRepository, this.storeRepository);

  @override
  Future<void> call(DomainEventNotification<CartClosedEvent> command) async {
    var cart = await cartRepository.getById(command.event.cartId);
    var stores = <String>{};

    for (var produto in cart!.products) {
      stores.add(produto.storeId);
    }

    for (var storeId in stores) {
      var store = await storeRepository.getById(storeId);
      print(
          'Enviando email de nova venda para: ${store!.emailToNotifications}');
    }
  }
}
