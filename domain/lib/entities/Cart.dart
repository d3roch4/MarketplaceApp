import 'package:domain/entities/Address.dart';
import 'package:domain/entities/ChosenProduct.dart';
import 'package:domain/events/CartClosedEvent.dart';
import 'package:domain/exceptions/CloseCardWhitoutAddresWithProductPhysicalException.dart';
import 'Entity.dart';
import 'Product.dart';

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
        if (products.any((p) => p.physical) && shippingAddress == null) {
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
