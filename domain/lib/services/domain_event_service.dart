import 'package:domain/events/domain_event.dart';

abstract class DomainEventService {
  Future callAll(List<DomainEvent> events);
}
