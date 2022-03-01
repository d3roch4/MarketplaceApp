import 'package:domain/repository/repository_base.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:domain/services/domain_event_service.dart';

abstract class MarketplaceRepository extends RepositoryBase<Marketplace> {
  MarketplaceRepository(DomainEventService eventService) : super(eventService);

  Future<Marketplace?> getFirst();
  Stream<List<Marketplace>> getAllMarketplacesStream();
}
