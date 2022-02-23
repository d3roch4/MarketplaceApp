
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:domain/events/domain_event.dart';

class DomainEventNotification<T extends DomainEvent> extends IAsyncCommand{
  T event;

  DomainEventNotification(this.event);
}