import 'package:domain/events/DomainEvent.dart';

class Entity {
  String? id;
  DateTime createdAt = DateTime.now();
  DateTime? modifiedAt;
  List<DomainEvent> domainEvents = [];

  @override
  bool operator ==(covariant Entity other) => other.id == id;
}
