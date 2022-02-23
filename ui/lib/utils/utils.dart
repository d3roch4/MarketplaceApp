import 'package:intl/number_symbols_data.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String? getCurrentLocale() {
  final locale = Get.locale;
  final joined = "${locale!.languageCode}_${locale.countryCode}";
  if (numberFormatSymbols.keys.contains(joined)) {
    return joined;
  }
  return locale.languageCode == 'und' ? 'pt_BR' : locale.languageCode;
}

final formatCurrency = NumberFormat.simpleCurrency(locale: getCurrentLocale());
final formatDateTime = DateFormat('dd/MM/yyyy HH:mm', getCurrentLocale());
final formatNumber = NumberFormat.decimalPattern(getCurrentLocale());

void nextFocus() => FocusManager.instance.primaryFocus!.nextFocus();

void showSnack(String msg, [SnackBarAction? action]) {
  ScaffoldMessenger.of(Get.context!).clearSnackBars();
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: Duration(seconds: 15),
    content: Text(msg),
    action: action,
  ));
}

Future<void> errorSnack(Object erro, [StackTrace st = StackTrace.empty]) {
  showSnack('errorSnack'.trParams({'msg': erro.toString()}));
  print('Error: $erro: \n$st');
  return Future.error(erro, st);
}

void desfazerSnack(VoidCallback func, {String msg = 'What to undo?'}) {
  ScaffoldMessenger.of(Get.context!).clearSnackBars();
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: Duration(seconds: 10),
    content: Text(msg.tr),
    action: SnackBarAction(label: 'Undo'.tr, onPressed: func),
  ));
}
