import 'package:domain/entities/currency.dart';
import 'package:domain/entities/money.dart';

abstract class CurrencyConverterService {
  Money to(Money money, [Currency currency = Currency.ethereum]) {
    if (money.currency == currency) return money;
    if (currency == Currency.ethereum) return toEthereum(money);

    var eth = toEthereum(money);
    return fromEthereum(eth, currency);
  }

  Money toEthereum(Money money);

  Money fromEthereum(Money eth, Currency currency);
}
