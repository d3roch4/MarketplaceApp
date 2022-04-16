import 'package:domain/entities/entity.dart';
import 'package:domain/entities/money.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/services/balance_service.dart';
import 'package:domain/services/currency_converter_service.dart';

class Wallet extends Entity {
  String name;
  String userId;
  String type;
  String data;

  Wallet(
      {required this.name,
      required this.userId,
      required this.type,
      required this.data});

  void pay(Cart cart, BalanceService balanceService,
      CurrencyConverterService converterService) {
    if (cart.totalValue(converterService) > balanceService.getBalance(this))
      throw ArgumentError(
          'The total value of cart is greater than the balance in the wallet');
    
  }
}
