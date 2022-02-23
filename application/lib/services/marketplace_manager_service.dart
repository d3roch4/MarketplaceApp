import 'package:domain/entities/marketplace.dart';

abstract class MarketplaceManagerService {
  Marketplace? current;

  Future<Marketplace?> currentMarketplace();
}
