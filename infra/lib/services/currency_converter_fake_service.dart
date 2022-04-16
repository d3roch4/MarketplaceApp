import 'dart:math';

import 'package:domain/entities/money.dart';
import 'package:domain/entities/currency.dart';
import 'package:domain/services/currency_converter_service.dart';

class CurrencyConverterFakeService extends CurrencyConverterService {
  var random = Random();

  @override
  Money fromEthereum(Money eth, Currency currency) {
    return Money(value: eth.value * random.nextDouble(), currency: currency);
  }

  @override
  Money toEthereum(Money money) {
    return Money(value: money.value * random.nextDouble(), currency: Currency.ethereum);
  }
}
