import 'package:domain/events/DomainEvent.dart';

class OrderCreateEvent extends DomainEvent {
  String orderId;

  OrderCreateEvent(this.orderId);
}
