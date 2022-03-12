import 'dart:async';

import 'package:ai_barcode/ai_barcode.dart';
import 'package:domain/entities/field.dart';
import 'package:flutter/material.dart';
import 'package:application/product/create_edit_product_command.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:turbine/widgets/money_form_field.dart';
import 'package:infra/services/barcode_search.dart';

class CreateProductPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var command = CreateEditProductCommand().obs;
  var barcode = Field<String>(name: "barcode");
  Timer? timerSearchBarCode;
  var barcodeSearch = Get.find<BarcodeSearch>();

  CreateProductPage() {
    command.value.storeId = Get.parameters['store']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New product'.tr),
        ),
        body: Form(
            key: formKey,
            child: Obx(() => ListView(
                  padding: EdgeInsets.all(kPadding),
                  children: [
                    TextFormField(
                      controller: TextEditingController(text: command.value.name),
                      decoration: InputDecoration(labelText: "Name".tr),
                      onChanged: (v) => command.value.name,
                      validator: (v) =>
                          v?.isEmpty ?? true ? "input a name".tr : null,
                    ),
                    TextFormField(
                      controller:
                          TextEditingController(text: command.value.description),
                      decoration: InputDecoration(
                          labelText: "Description".tr,
                          hintText: "Brief summary".tr),
                      onChanged: (v) => command.value.name = v,
                    ),
                    MoneyFormField(
                      money: command.value.price,
                      onChange: (v) => command.value.price = v,
                    ),
                    Row(children: [
                      Flexible(
                          child: RadioListTile<bool>(
                              title: Text("Physical".tr),
                              value: true,
                              groupValue: command.value.physical,
                              onChanged: (v) => command.value.physical = v!)),
                      Flexible(
                          child: RadioListTile<bool>(
                              title: Text("Virtual".tr),
                              value: false,
                              groupValue: command.value.physical,
                              onChanged: (v) => command.value.physical = v!)),
                    ]),
                    if (command.value.physical)
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Stock",
                            hintText: "Quantity in stock".tr),
                        onChanged: (v) =>
                            command.value.stockCount = int.tryParse(v) ?? 0,
                      )
                  ],
                ))),
        floatingActionButton: Column(
          children: [
            FloatingActionButton.small(
              child: Icon(Icons.bar_chart),
              onPressed: readCode,
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.save),
              label: Text('Save'.tr),
              onPressed: save,
            )
          ],
        ));
  }

  void save() {
    if (formKey.currentState!.validate()) Mediator.instance.run(command.value);
    Get.back();
  }

  void readCode() {
    var scannerController = ScannerController(scannerResult: findDataByBarCode);
    Get.to(() => PlatformAiBarcodeScannerWidget(
          platformScannerController: scannerController,
        ));
  }

  void findDataByBarCode(String code) {
    timerSearchBarCode?.cancel();
    timerSearchBarCode = Timer(Duration(microseconds: 500), () async {
      command.value = (await barcodeSearch.serach(code)) ?? command.value;
    });
  }
}
