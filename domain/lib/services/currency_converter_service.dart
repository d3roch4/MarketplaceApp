import 'package:domain/entities/money.dart';

abstract class CurrencyConverterService {
  Money to(Money money, [String currency = Currencies.ethereum]) {
    if (money.currency == currency) return money;
    if (currency == Currencies.ethereum) return toEthereum(money);

    var eth = toEthereum(money);
    return fromEthereum(eth, currency);
  }

  Money toEthereum(Money money);

  Money fromEthereum(Money eth, String currency);
}
