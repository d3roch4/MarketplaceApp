import 'package:domain/entities/order.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:domain/entities/money.dart';
import 'utils.dart';

extension StatusOrderString on StatusOrder {
  String toStringFormatted() {
    switch (this) {
      case StatusOrder.unknown:
        return "Unknown".tr;
      case StatusOrder.waitingForSeller:
        return "Waiting for seller".tr;
      case StatusOrder.rejected:
        return "Rejected".tr;
      case StatusOrder.processing:
        return "Processing".tr;
      case StatusOrder.canceled:
        return "Canceled".tr;
    }
  }
}

extension MoneyFormat on Money {
  String toStringFormatted() {
    var formarter = NumberFormat.currency(
      locale: getCurrentLocale(),
      name: currency.code,
      symbol: currency.symbol,
      decimalDigits: currency.decimalDigits,
    );
    return formarter.format(value);
  }
}
