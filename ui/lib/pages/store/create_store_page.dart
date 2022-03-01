import 'package:flutter/material.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:application/store/create_store.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';

class CreateStorePage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var command = CreateStoreCommand();

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
              onChanged: (v) => command.name = v,
              onEditingComplete: nextFocus,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'.tr),
              validator: (v) => (v == null || v.isEmpty || !v.contains('@'))
                  ? 'Please provide an valid email'.tr
                  : null,
              onChanged: (v) => command.email = v,
              onEditingComplete: nextFocus,
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
    if (!formKey.currentState!.validate()) return;
    try {
      var id = await Mediator.instance.run(command);
      Get.back(result: id);
    } catch (ex, st) {
      errorSnack(ex.toString(), st);
    }
  }
}
