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

class CreateProductPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var command = CreateEditProductCommand();
  var physical = true.obs;
  var barCode = Field<String>(name: "Code bar");
  Timer? timerSearchBarCode;

  CreateProductPage() {
    command.storeId = Get.parameters['store']!;
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
                      controller: TextEditingController(text: command.name),
                      decoration: InputDecoration(labelText: "Name".tr),
                      onChanged: (v) => command.name,
                      validator: (v) =>
                          v?.isEmpty ?? true ? "input a name".tr : null,
                    ),
                    TextFormField(
                      controller:
                          TextEditingController(text: command.description),
                      decoration: InputDecoration(
                          labelText: "Description".tr,
                          hintText: "Brief summary".tr),
                      onChanged: (v) => command.name = v,
                    ),
                    MoneyFormField(
                      money: command.price,
                      onChange: (v) => command.price = v,
                    ),
                    Row(children: [
                      Flexible(
                          child: RadioListTile<bool>(
                              title: Text("Physical".tr),
                              value: true,
                              groupValue: physical.value,
                              onChanged: (v) =>
                                  physical.value = command.physical = v!)),
                      Flexible(
                          child: RadioListTile<bool>(
                              title: Text("Virtual".tr),
                              value: false,
                              groupValue: physical.value,
                              onChanged: (v) =>
                                  physical.value = command.physical = v!)),
                    ]),
                    if (command.physical)
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Stock",
                            hintText: "Quantity in stock".tr),
                        onChanged: (v) =>
                            command.stockCount = int.tryParse(v) ?? 0,
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
    if (formKey.currentState!.validate()) Mediator.instance.run(command);
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
    timerSearchBarCode = Timer(Duration(microseconds: 500), (){

    });
  }
}
