import 'package:domain/events/DomainEvent.dart';

class CartClosedEvent extends DomainEvent {
  String cartId;

  CartClosedEvent(this.cartId);
}
