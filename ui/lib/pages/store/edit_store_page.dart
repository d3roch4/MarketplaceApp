import 'package:domain/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:flutter/material.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:application/store/create_store_command.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/loadding_widget.dart';

class EditStorePage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var command = CreateStoreCommand();
  var store = Rx<Store?>(null);
  late Future<Store> loadding;

  EditStorePage(String? id) {
    loadding = initStore(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Store edit'.tr)),
      body: LoaddingWidget.future(
          future: loadding,
          builder: (d) => Form(
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
                      validator: (v) =>
                          (v == null || v.isEmpty || !v.contains('@'))
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
              )),
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

  Future<Store> initStore(String? id) async {
    if (id == null) return Future.error('Store not found'.tr);
    var repo = Get.find<StoreRepository>();
    var store = await repo.getById(id);
    if (store == null) return Future.error('Store not found'.tr);
    command.name = store.name;
    command.email = store.emailToNotifications;
    return this.store.value = store;
  }
}
