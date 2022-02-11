
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/events/DomainEvent.dart';

class DomainEventNotification<T extends DomainEvent> extends IAsyncCommand{
  T event;

  DomainEventNotification(this.event);
}