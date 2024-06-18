import 'package:flutter/material.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/product/ui/widget/product_detail_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProductDetailWidget(
      product: widget.product,
    );
  }
}
