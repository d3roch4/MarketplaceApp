import 'package:domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turbine/utils/extensions.dart';
import 'package:turbine/utils/utils.dart';

class ProductCard extends StatelessWidget {
  Product product;
  void Function(Product)? onTap;

  ProductCard({required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap == null ? null : ()=> onTap!(product),
      child: Card(
          // color: product.selo==null? null: Color(product.selo.cor),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Get.theme.primaryColor, width: 5),
              borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(children: [
              Stack(fit: StackFit.passthrough, children: [
                Hero(
                  tag: product.id!,
                  child: product.media.isEmpty
                  ? imageDefault()
                  : CachedNetworkImage(
                      imageUrl: product.media[0],
                      fit: BoxFit.fitWidth,
                      errorWidget: (c, u, e) => imageDefault(),
                    ),
                ),
                Positioned(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: Text(product.price.toString()),
                  ),
                  top: 8,
                  right: 8,
                ),
                Positioned(
                  left: 0, right: 0,
                  bottom: 0,
                  child: GridTileBar(
                    backgroundColor: Colors.black.withOpacity(.5),
                    title: Text(product.name, style: Get.textTheme.subtitle1),
                  ),
                )
              ]),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(kPadding/2),
                color: Colors.black.withOpacity(.5),
                child: Text(product.description, style: Get.textTheme.bodyText2),              
              ),
            ]),
          )),
    );
  }

  Widget imageDefault() => Icon(Icons.image, size: 150);
}
