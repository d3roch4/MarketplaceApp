import 'package:domain/entities/money.dart';
import 'package:domain/entities/wallet.dart';

abstract class BalanceService {
  Money getBalance(Wallet wallet);
}
