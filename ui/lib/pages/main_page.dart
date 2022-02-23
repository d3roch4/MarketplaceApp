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
import 'package:turbine/utils/global_values.dart';

class MainPage extends StatelessWidget {
  var selectedIndex = 0.obs;
  var userManager = Get.find<UserManagerService>();

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
              return Scaffold(
                appBar: AppBar(title: Text(marketplace.name)),
                body: _body(),
                // selectedIndex: selectedIndex.value,
                // onDestinationSelected: (value) => selectedIndex.value = value,
                // destinations: [
                //   AdaptiveScaffoldDestination(title: 'Home'.tr, icon: Icons.home),
                //   AdaptiveScaffoldDestination(
                //       title: 'Settings'.tr, icon: Icons.settings),
                // ],
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: showHideMenu,
                ),
                // navigationTypeResolver: (context) {
                //   if (MediaQuery.of(context).size.width > 600) {
                //     return NavigationType.drawer;
                //   } else {
                //     return NavigationType.bottom;
                //   }
                // }
              );
            }),
    );
  }

  Widget _body() {
    switch (selectedIndex.value) {
      case 0:
        return HomePage();
      default:
        return Center(child: Icon(Icons.free_breakfast));
    }
  }

  void showHideMenu() {
    showSlidingBottomSheet(Get.context!, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        headerBuilder: (c, state) => Container(
          height: 56,
          width: double.infinity,
          color: Colors.green,
          alignment: Alignment.center,
          child: Text(
            'Menu'.tr,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        builder: (context, state) {
          return Material(
              child: userManager.current == null
                  ? menuUserNotLogged()
                  : menuUserLogged());
        },
      );
    });
  }

  Widget menuUserNotLogged() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.login),
          title: Text("Sign in".tr),
          subtitle: Text("Is free".tr),
          onTap: () => Get.toNamed("/login/signin"),
        ),
        ListTile(
          leading: Icon(Icons.app_registration),
          title: Text("Sign up".tr),
          subtitle: Text("Is free".tr),
          onTap: () => Get.toNamed("/login/signup"),
        )
      ],
    );
  }

  Widget menuUserLogged() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Purchases".tr),
          subtitle: Text("See your purchase history".tr),
        ),
        ListTile(
          leading: Icon(Icons.store),
          title: Text("Sales".tr),
          subtitle: Text("Manager your salles".tr),
          onTap: ()=> Get.toNamed('/manager-stores'),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Loggout".tr),
        ),
      ],
    );
  }
}
