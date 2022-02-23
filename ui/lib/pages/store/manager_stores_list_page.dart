import 'package:application/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:application/store/get_stores_by_user.dart';

class ManagerStoresListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager stores".tr),
      ),
      body: LoaddingWidget.future<List<Store>>(
          future: Mediator.instance.run(GetStoresByUserQuery()),
          builder: (list) {
            if (list == null) return empty();
            return ListView.separated(
              itemBuilder: (c, i) {
                var item = list[i];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.emailToNotifications),
                );
              },
              itemCount: list.length,
              separatorBuilder: (c, i) => Divider(),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'.tr),
        icon: Icon(Icons.add),
        onPressed: add,
      ),
    );
  }

  Widget empty() => Text('Register your store and sell a lot'.tr);

  Future<void> add() async {
    var storeId = await Get.toNamed('/manager-stores/add');
    if (storeId == null) return;
    Get.toNamed('/manager-stores/$storeId');
  }
}
