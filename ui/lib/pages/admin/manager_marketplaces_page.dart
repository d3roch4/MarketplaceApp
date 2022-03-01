import 'package:domain/repository/marketplace_repository.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:turbine/widgets/loadding_widget.dart';

class ManagerMarketplacesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marketplaces'.tr)),
      body: LoaddingWidget.stream<List<Marketplace>>(
          stream: listMarketplaces(),
          builder: (marketplaces) => marketplaces == null
              ? emptyText()
              : ListView.separated(
                  itemBuilder: (c, i) => itemBuilder(marketplaces[i]),
                  separatorBuilder: (c, i) => Divider(),
                  itemCount: marketplaces.length)),
      floatingActionButton: FloatingActionButton(
        onPressed: addMarketplace,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemBuilder(Marketplace marketplace) {
    return ListTile(
      title: Text(marketplace.name),
      subtitle: Text(marketplace.subDomain ?? ''),
      leading: Icon(Icons.shopping_basket),
    );
  }

  Widget emptyText() => Text('Create first marketplace'.tr);

  Stream<List<Marketplace>> listMarketplaces() {
    var repo = Get.find<MarketplaceRepository>();
    return repo.getAllMarketplacesStream();
  }

  void addMarketplace() {
    Get.toNamed('/admin/marketplaces/add');
  }
}
