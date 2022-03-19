import 'package:domain/entities/chosen_product.dart';
import 'package:domain/events/cart_closed_event.dart';
import 'package:domain/exceptions/close_card_whitout_addres_with_product_physical_exception.dart';

import 'address.dart';
import 'entity.dart';

class Cart extends Entity {
  String buyerId;
  List<ChosenProduct> products = [];
  Address? shippingAddress;
  CartStatus _status = CartStatus.unknown;

  CartStatus get status => _status;

  set status(CartStatus status) {
    switch (status) {
      case CartStatus.unknown:
        break;
      case CartStatus.closed:
        if (products.any((p) => p.stockCheck) && shippingAddress == null) {
          throw CloseCardWhitoutAddresWithProductPhysicalException();
        }
        domainEvents.add(CartClosedEvent(id!));
        break;
      case CartStatus.opened:
        break;
    }
    _status = status;
  }

  Cart({required this.buyerId});
}

enum CartStatus {
  unknown,
  opened,
  closed,
}
