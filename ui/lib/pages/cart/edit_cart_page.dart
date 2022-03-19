import 'package:domain/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/loadding_page.dart';

class EditCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoaddingPage.future<Cart>(
        future: loaddingCart(),
        builder: (cart) {
          return Scaffold(
            appBar: AppBar(),
          );
        });
  }

  loaddingCart() {}
}
