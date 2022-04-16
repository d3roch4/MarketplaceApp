import 'package:domain/entities/wallet.dart';
import 'package:domain/repository/repository_base.dart';
import 'package:domain/services/domain_event_service.dart';
import 'package:domain/entities/wallet.dart';

abstract class WalletRepository extends RepositoryBase<Wallet> {
  WalletRepository(DomainEventService eventService) : super(eventService);

  Future<List<Wallet>> listAll();
}
