import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';
import 'package:shoesly/feature/cart/ui/widget/add_to_cart_bottomsheet.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/reviews/cubit/review_cubit.dart';
import 'package:shoesly/feature/reviews/ui/widget/review_widget_product_detail.dart';

class ProductDetailWidget extends StatefulWidget {
  ProductDetailWidget({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<ReviewCubit>().addReview();
    context.read<ReviewCubit>().fetchReviewList(
          productId: widget.product.id,
          limit: 10,
        );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(
        "Product Detail",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color.fromARGB(255, 186, 183, 183),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                "https://t3.ftcdn.net/jpg/01/21/81/86/360_F_121818673_6EID5iF76VCCc4aGOLJkd94Phnggre3o.jpg",
                                // height: 100.0,
                                width: 100.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.product.name}',
                            style: _theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Row(children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < widget.product.rating.floor()
                                      ? Icons.star
                                      : widget.product.rating -
                                                  index.toDouble() >=
                                              1
                                          ? Icons.star
                                          : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20,
                                );
                              }),
                            ),
                            Gap(4),
                            Text(
                              '${widget.product.rating}',
                              style: _theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ]),
                          Gap(28.0),
                          Text(
                            'Size',
                            style: _theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                          Gap(8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                widget.product.size.length,
                                (index) => Container(
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 186, 183, 183),
                                      )),
                                  child: Text(
                                    '${widget.product.size[index]}',
                                    style: _theme.textTheme.titleMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Colors.black54),
                                  ),
                                  margin: EdgeInsets.only(right: 8.0),
                                ),
                              ),
                            ),
                          ),
                          Gap(28.0),
                          Text(
                            'Description',
                            style: _theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                          Gap(8),
                          Text(
                            '${widget.product.description}',
                            style: _theme.textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
                            ),
                          ),
                          ReviewWidgetProductDetail(
                            productId: widget.product.id,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: _theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          '\$${widget.product.price}',
                          style: _theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                      ]),
                  Gap(CustomTheme.symmetricHozPadding),
                  RoundedFilledButton(
                      textColor: Colors.white,
                      onPressed: () {
                        openAddToCartBottomSheet(
                          context,
                          widget.product,
                        );
                      },
                      verticalPadding: 20,
                      title: "Add to cart",
                      backgroundColor: Colors.black,
                      borderColor: Colors.white),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
