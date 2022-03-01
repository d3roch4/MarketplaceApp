import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/entity.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class UserRepository extends RepositoryBase<User> {
  UserRepository(DomainEventService eventService) : super(eventService);
}
