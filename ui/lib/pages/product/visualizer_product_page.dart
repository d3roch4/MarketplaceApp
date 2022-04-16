import 'package:application/cart/add_product_to_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:domain/entities/cart.dart';
import 'package:domain/entities/product.dart';
import 'package:domain/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:turbine/pages/loadding_page.dart';
import 'package:turbine/pages/not_found_page.dart';
import 'package:turbine/utils/utils.dart';
import 'package:turbine/widgets/create_botton_app_bar.dart';
import 'package:turbine/widgets/loadding_widget.dart';
import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:cqrs_mediator/cqrs_mediator.dart';

class VisualizerProductPage extends StatelessWidget {
  Product? _product;
  var adding = false.obs;

  @override
  Widget build(BuildContext context) {
    return LoaddingPage.future<Product?>(
        initialData: Get.arguments,
        future: getProduct(),
        builder: (product) {
          _product = product;
          if (product == null) return NotFoundPage();
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(onPressed: favorite, icon: Icon(Icons.favorite)),
                IconButton(onPressed: share, icon: Icon(Icons.share))
              ],
            ),
            body: ListView(
              padding: EdgeInsets.all(kPadding),
              children: [
                Hero(tag: product.id!, child: imgage(product)),
                Text(product.name, style: Get.textTheme.headline6),
                Text(product.description)
              ],
            ),
            floatingActionButton: Obx(() => adding.value == true
                ? CircularProgressIndicator()
                : FloatingActionButton.extended(
                    label: Text("Buy".tr),
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: addToChart,
                  )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: createBottomAppBar(Text(product.price.toStringFormatted(),
              style: Get.textTheme.headline6)),
          );
        });
  }

  void favorite() {}

  Future<Product?> getProduct() {
    return Get.find<ProductRepository>().getById(Get.parameters["id"]!);
  }

  Widget urlToMedia(String url) {
    if (url.startsWith("https://youtube"))
      return YoutubePlayerIFrame(
        controller: YoutubePlayerController(
          initialVideoId: Uri.parse(url).queryParameters["v"] ?? "",
          params: YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ),
        ),
        aspectRatio: 16 / 9,
      );
    else
      return CachedNetworkImage(
        fit: BoxFit.fitWidth,
        imageUrl: url,
      );
  }

  List<Widget> medias(List<String> media) =>
      media.map<Widget>(urlToMedia).toList();

  Widget imgage(Product product) {
    if (product.media.length == 1) return urlToMedia(product.media[0]);
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlay: product.media.length > 1,
        pauseAutoPlayOnTouch: true,
      ),
      items: medias(product.media),
    );
  }

  Future<void> addToChart() async {
    adding.value = true;
    var command = AddProductToCartCommand(_product!.id!, 1);
    var cart = await Mediator.instance.run(command) as Cart;
    await Get.toNamed('/carts/opened', arguments: cart);
    adding.value = false;
  }

  void share() {}
}
