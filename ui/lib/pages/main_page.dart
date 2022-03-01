import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:application/services/marketplace_manager_service.dart';
import 'package:application/services/user_manager_service.dart';
import 'package:domain/entities/marketplace.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:turbine/pages/error_page.dart';
import 'package:turbine/pages/home_page.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:turbine/pages/settings_page.dart';
import 'package:turbine/utils/global_values.dart';

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
              return AdaptiveNavigationScaffold(
                appBar: AdaptiveAppBar(title: Text(marketplace.name)),
                body: _body(),
                selectedIndex: selectedIndex.value,
                onDestinationSelected: (value) => selectedIndex.value = value,
                destinations: [
                  AdaptiveScaffoldDestination(title: 'Home'.tr, icon: Icons.home),
                  AdaptiveScaffoldDestination(
                      title: 'Settings'.tr, icon: Icons.settings),
                ],
                navigationTypeResolver: (context) {
                  if (MediaQuery.of(context).size.width > 600) {
                    return NavigationType.permanentDrawer;
                  } else {
                    return NavigationType.bottom;
                  }
                }
              );
            }),
    );
  }

  Widget _body() {
    switch (selectedIndex.value) {
      case 0:
        return HomePage();
      default:
        return SettingsPage();
    }
  }
 }
