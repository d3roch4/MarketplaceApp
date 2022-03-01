import 'package:domain/entities/order.dart';
import 'package:domain/repository/store_repository.dart';
import 'package:domain/entities/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:application/store/last_orders_by_sotre_query.dart';
import 'package:turbine/utils/utils.dart';

class StorePanelPage extends StatelessWidget {
  Store? store;

  StorePanelPage([this.store]) {
    if (Get.arguments is Store) store = Get.arguments;
  }

  Widget _buildPanel(Store store) {
    return Scaffold(
      appBar: AppBar(title: Text(store.name),),
      body: ListView(
        padding: EdgeInsets.all(kPadding),
        children: [
          Text("Latest ordes".tr),
          getDataTableOrders(),
          Wrap(children: [
            OutlinedButton.icon(
              icon: Icon(Icons.inventory),
              label: Text("Products".tr),
              onPressed: managerProducts,
            )
          ]),
          Text("Carts".tr),
          Wrap(children: [
            Container(height: 100, width: 100, color: Colors.red, margin: EdgeInsets.all(1),),
            Container(height: 100, width: 100, color: Colors.red, margin: EdgeInsets.all(1),),
            Container(height: 100, width: 100, color: Colors.red, margin: EdgeInsets.all(1),),
            Container(height: 100, width: 100, color: Colors.red, margin: EdgeInsets.all(1),),
          ]),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return store != null
        ? _buildPanel(store!)
        : LoaddingPage.future<Store>(
            future: getStore(),
            builder: (data) {
              store = data;
              return _buildPanel(store!);
            },
          );
  }

  Future<Store> getStore() async {
    var store =
        await Get.find<StoreRepository>().getById(Get.parameters["id"]!);
    if (store == null) return Future.error("Not found");
    return store;
  }

  getDataTableOrders() => LoaddingWidget.future<List<OrderBuyer>>(
      future: getListOrder(),
      builder: (orders) => DataTable(
            columns: [
              DataColumn(label: Text("Buyer")),
              DataColumn(label: Text("Value")),
              DataColumn(label: Text("Date/Time")),
              DataColumn(label: Text("Status")),
            ],
            rows: [
              for (var ob in orders!)
                DataRow(cells: [
                  DataCell(Text(ob.buyer.name)),
                  DataCell(Text(
                      ob.order.totalValue(Get.find()).toStringFormatted())),
                  DataCell(Text(formatDateTime.format(ob.order.createdAt))),
                  DataCell(Text(ob.order.status.toStringFormatted())),
                ])
            ],
          ));

  void managerProducts() {
    Get.toNamed('/manager-stores/:id/products', arguments: store);
  }

  Future<List<OrderBuyer>> getListOrder() {
    return Mediator.instance.run(LastOrdersByStoreQuery(store!.id!));
  }
}
