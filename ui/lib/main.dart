import 'dart:ui';
import 'package:domain/entities/marketplace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:turbine/pages/admin/create_edit_marketplace_page.dart';
import 'package:turbine/pages/admin/manager_marketplaces_page.dart';
import 'package:turbine/pages/main_page.dart';
import 'package:turbine/pages/login/sign_in.dart';
import 'package:turbine/pages/login/sign_up.dart';
import 'package:turbine/pages/not_found_page.dart';
import 'package:turbine/pages/store/create_store_page.dart';
import 'package:turbine/pages/store/manager_store_page.dart';
import 'package:turbine/pages/store/manager_stores_list_page.dart';
import 'package:turbine/theme_app.dart';
import 'package:turbine/utils/messages_translations.dart';
import 'configure.dart' if (dart.library.html) 'configure_web.dart';

Future<void> main() async {
  await configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var theme = ThemeApp();

    return GetMaterialApp(
      title: "Turbine",
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Get.deviceLocale,
      translations: MessagesTranslations(),
      defaultTransition: Transition.leftToRight,
      getPages: [
        GetPage(name: '/', page: () => MainPage(selectedIndex: 0)),
        GetPage(name: '/login/signin', page: () => SignIn()),
        GetPage(name: '/login/signup', page: () => SignUp()),
        GetPage(
            name: '/admin/marketplaces', page: () => ManagerMarketplacesPage()),
        GetPage(
            name: '/admin/marketplaces/add',
            page: () => CreateEditMarketplacePage()),
        GetPage(name: '/manager-stores', page: ()=> ManagerStoresListPage()),
        GetPage(name: '/manager-stores/add', page: ()=> CreateStorePage()),
      ],
      unknownRoute: GetPage(name: '/not-found', page: () => NotFoundPage()),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
