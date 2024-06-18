import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/feature/product/cubit/category_cubit.dart';
import 'package:shoesly/feature/product/cubit/product_cubit.dart';
import 'package:shoesly/feature/product/ui/widget/product_list_widget.dart';

class ProductListPageScreen extends StatefulWidget {
  const ProductListPageScreen({Key? key}) : super(key: key);

  @override
  _ProductListPageScreenState createState() => _ProductListPageScreenState();
}

class _ProductListPageScreenState extends State<ProductListPageScreen> {
  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategory();
    context.read<ProductCubit>().fetchProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProductListWidget();
  }
}
