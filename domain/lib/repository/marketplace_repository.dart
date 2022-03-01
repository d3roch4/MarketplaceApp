import 'package:application/repository/repository_base.dart';
import 'package:domain/entities/marketplace.dart';

abstract class MarketplaceRepository extends RepositoryBase<Marketplace> {
  Future<Marketplace?> getFirst();
  Stream<List<Marketplace>> getAllMarketplacesStream();
}
