import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/product/ui/widget/common_grid_view.dart';
import 'package:shoesly/feature/product/ui/widget/product_card.dart';

class ProductItemGridSection extends StatelessWidget {
  ProductItemGridSection({
    Key? key,
    required this.products,
    required this.isLoadMoreActive,
    required this.isLoadMoreEnabled,
    required this.loadMore,
    required this.refreshController,
  }) : super(key: key);
  final List<Product> products;
  final bool isLoadMoreActive;
  final bool isLoadMoreEnabled;
  final Function loadMore;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return CommonGridView(
      isLoadMoreActive: isLoadMoreActive,
      isLoadMoreEnabled: isLoadMoreEnabled,
      loadMore: loadMore,
      refreshController: refreshController,
      onRefresh: () {},
      mainAxisExtent: 125 + 8.hp + 14 + 14.hp + 12 + 30.hp + 12 + 16,
      desiredItemWidth: 46.w,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
