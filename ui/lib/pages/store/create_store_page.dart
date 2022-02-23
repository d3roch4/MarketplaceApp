import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:application/store/create_store.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';

class CreateStorePage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var storeCommand = CreateStoreCommand();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Store registration'.tr)),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(kPadding),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'.tr),
              validator: (v) => v == null || v.isEmpty
                  ? 'Please, enter with a name'.tr
                  : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'.tr),
              validator: (v) => (v == null || v.isEmpty || !v.contains('@')) 
                ? 'Please provide an valid email'.tr 
                : null,
            ),
            SizedBox(height: kPadding),
            ElevatedButton(
              child: Text('Save'.tr),
              onPressed: save,
            )
          ],
        ),
      ),
    );
  }

  Future<void> save() async {
    try {
      var id = await Mediator.instance.run(storeCommand);
      Get.back(result: id);
    } catch (ex, st) {
      errorSnack(ex.toString(), st);
    }
  }
}
