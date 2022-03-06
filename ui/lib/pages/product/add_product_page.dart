import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:application/product/create_product_command.dart';

class AddProductPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var command = CreateProductCommand();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New product'.tr),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(kPadding),
            children: [
              TextFormField(
                controller: TextEditingController(text: command.name),
                decoration: InputDecoration(labelText: "Name".tr),
                onChanged: (v)=> command.name,
                validator: (v)=> v?.isEmpty??true ? "input a name".tr: null,
              ),
              TextFormField(
                controller: TextEditingController(text: command.description),
                decoration: InputDecoration(labelText: "Description".tr, hintText: "Brief summary".tr),
                onChanged: (v)=> command.name = v,
              ),
            ],
          )),
    );
  }
}
