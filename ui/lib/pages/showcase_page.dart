import 'package:application/product/list_nearby_products_query.dart';
import 'package:domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/main_page_base.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:turbine/widgets/product_card.dart';
import 'package:get/get.dart';

class ShowcasePage extends MainPageBase {
  @override
  List<Widget>? actions() {
    return [IconButton(onPressed: search, icon: Icon(Icons.search))];
  }

  @override
  Widget build(BuildContext context) {
    return LoaddingWidget.stream<List<Product>>(
        stream: Mediator.instance.run(ListNearbyProductsQuery()),
        builder: (products) => products == null || products.isEmpty
            ? empty()
            : MasonryGridView.extent(
                maxCrossAxisExtent: 300,
                itemCount: products.length,
                mainAxisSpacing: kPadding,
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: products[index], onTap: openProduct);
                },
              ));
  }

  void search() {}

  Widget empty() => Center(child: Text('Cri-cri-cri! nothing here!'));

  void openProduct(Product product) {
    Get.toNamed("/products/${product.id}", arguments: product);
  }
}
