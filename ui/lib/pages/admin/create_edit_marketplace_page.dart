import 'package:application/marketplace/create_marketplace.dart';
import 'package:domain/repository/marketplace_repository.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbine/utils/global_values.dart';
import 'package:turbine/utils/utils.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';

class CreateEditMarketplacePage extends StatelessWidget {
  Marketplace marketplace;
  var formKey = GlobalKey<FormState>();
  var repository = Get.find<MarketplaceRepository>();

  CreateEditMarketplacePage({Marketplace? marketplace})
      : this.marketplace = marketplace ?? Marketplace(name: '', userId: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marketplace registration form'.tr)),
      body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(kPadding),
            children: [
              TextFormField(
                controller: TextEditingController(text: marketplace.name),
                decoration: InputDecoration(
                    labelText: 'Name'.tr, hintText: 'Marketplace name'.tr),
                validator: (v) => v?.isEmpty ?? true ? 'Give a name'.tr : null,
                onChanged: (v) => marketplace.name = v,
                keyboardType: TextInputType.name,
                onEditingComplete: nextFocus,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: TextEditingController(text: marketplace.subDomain),
                decoration: InputDecoration(
                    labelText: 'Subdomain'.tr, hintText: 'Marketplace url'.tr),
                validator: (v) =>
                    v?.isEmpty ?? true ? 'Give a subdomain'.tr : null,
                onChanged: (v) => marketplace.name = v,
                keyboardType: TextInputType.name,
                onEditingComplete: nextFocus,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: kPadding),
              ElevatedButton(
                child: Text('Save'.tr),
                onPressed: save,
              )
            ],
          )),
    );
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    await Mediator.instance
        .run(CreateMarketplaceCommand(
            name: marketplace.name,
            domains: marketplace.domains,
            subDomain: marketplace.subDomain))
        .catchError(errorSnack);
  }
}
