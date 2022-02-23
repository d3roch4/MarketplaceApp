import 'package:domain/events/domain_event.dart';

class OrderCreateEvent extends DomainEvent {
  String orderId;

  OrderCreateEvent(this.orderId);
}
