import 'package:domain/events/domain_event.dart';

class CartClosedEvent extends DomainEvent {
  String cartId;

  CartClosedEvent(this.cartId);
}
