import 'package:domain/entities/product.dart';
import 'package:flutter/material.dart';

class ImageProductWidget extends StatelessWidget {
  Product product;

  ImageProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.image);
  }
}
