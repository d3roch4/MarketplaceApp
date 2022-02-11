import 'package:application/repository/CartRepository.dart';
import 'package:application/repository/StoreRepository.dart';
import 'package:application/repository/UserRepository.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/entities/Product.dart';
import 'package:domain/entities/Store.dart';
import 'package:domain/events/CartClosedEvent.dart';

import 'DomainEventNotification.dart';

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
