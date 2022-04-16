import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:application/services/marketplace_manager_service.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/cart/edit_cart_page.dart';
import 'package:turbine/pages/cart/list_cats_page.dart';
import 'package:turbine/pages/error_page.dart';
import 'package:turbine/pages/showcase_page.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:turbine/pages/main_page_base.dart';
import 'package:turbine/pages/settings_page.dart';

class MainPage extends StatelessWidget {
  var selectedIndex = 0.obs;

  MainPage({int? selectedIndex}) {
    this.selectedIndex.value = selectedIndex ?? this.selectedIndex.value;
  }

  @override
  Widget build(BuildContext context) {
    return LoaddingPage.future<Marketplace?>(
      future: Get.find<MarketplaceManagerService>().currentMarketplace(),
      builder: (marketplace) => marketplace == null
          ? ErrorPage(message: "Martketplace not found".tr)
          : Obx(() {
              var page = getPage();
              return AdaptiveNavigationScaffold(
                  appBar: AdaptiveAppBar(
                    title: Text(marketplace.name),
                    actions: page.actions(),
                  ),
                  body: page,
                  selectedIndex: selectedIndex.value,
                  onDestinationSelected: (value) => selectedIndex.value = value,
                  destinations: [
                    AdaptiveScaffoldDestination(
                        title: 'Home'.tr, icon: Icons.home),
                    AdaptiveScaffoldDestination(
                        title: 'Cart'.tr, icon: Icons.shopping_cart),
                    AdaptiveScaffoldDestination(
                        title: 'Settings'.tr, icon: Icons.settings),
                  ],
                  navigationTypeResolver: (context) {
                    if (MediaQuery.of(context).size.width > 600) {
                      return NavigationType.permanentDrawer;
                    } else {
                      return NavigationType.bottom;
                    }
                  });
            }),
    );
  }

  MainPageBase getPage() {
    switch (selectedIndex.value) {
      case 0:
        return ShowcasePage();
      case 1:
        return ListCartsPage();
      default:
        return SettingsPage();
    }
  }
}
