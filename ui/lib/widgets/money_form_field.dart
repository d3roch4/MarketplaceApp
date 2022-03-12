import 'package:domain/entities/money.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:turbine/utils/utils.dart';

class MoneyFormField extends StatelessWidget {
  var money = Rx<Money?>(null);
  void Function(Money) onChange;
  final formatCurrency =
      NumberFormat.currency(locale: getCurrentLocale(), symbol: '');

  MoneyFormField({required this.onChange, Money? money}) {
    this.money.value = money;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextFormField(
      controller: TextEditingController(
          text: formatCurrency.format(money.value?.value)),
      decoration: InputDecoration(
        labelText: "Price".tr,
        prefixText: money.value?.currency.symbol,
        icon: SizedBox(width: 60, child: DropdownButtonFormField<Currency>(
          decoration: InputDecoration(labelText: 'Currency'.tr),
          isExpanded: false,
          items: Currency.values.map((e) => DropdownMenuItem<Currency>(
            child: Text(e.code),
            value: e,
          )).toList(),
          value: money.value?.currency,
          onChanged: setPriceCurrency,
        ))
      ),
      onChanged: setPriceValue,
      onEditingComplete: nextFocus,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      // inputFormatters: <TextInputFormatter>[ // is need check currency for formatter
      //     FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      // ],
    ));
  }

  void setPriceCurrency(Currency? value) {
    money.value?.currency = value!;
    money.refresh();
    nextFocus();
  }

  void setPriceValue(String value) {
    money.value?.value = value.isEmpty
      ? 0
      : formatCurrency.parse(value).toDouble();
  }
}
