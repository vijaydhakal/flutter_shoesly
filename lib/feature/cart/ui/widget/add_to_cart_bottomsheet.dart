import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/widget/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/common/widget/toast.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_cubit.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_state.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';
import 'package:shoesly/feature/cart/ui/widget/add_to_cart_success.dart';
import 'package:shoesly/feature/product/model/product_model.dart';

//function to open bottomsheet
Future<void> openAddToCartBottomSheet(BuildContext context, Product product) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return AddToCartBottomSheet(product: product);
    },
  );
}

class AddToCartBottomSheet extends StatefulWidget {
  final Product product;

  const AddToCartBottomSheet({Key? key, required this.product})
      : super(key: key);

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;

  void onAddToCart() {
    // Create new cart item
    CartItemModel cartItem = CartItemModel(
      id: widget.product.id,
      productId: widget.product.id.toString(),
      price: widget.product.price * quantity.toDouble(),
      quantity: quantity,
      size: widget.product.size.first,
      productInfo: widget.product,
    );
    // Add event AddToCart
    context.read<CartUpdateCubit>().addCart(cart: cartItem);
  }

  final ValueNotifier _isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BlocConsumer<CartUpdateCubit, CartUpdateState>(
      listener: (context, state) {
        if (state is CartUpdateLoading) {
          _isLoading.value = true;
        }
        if (state is CartUpdateSuccess) {
          _isLoading.value = false;
          openAddToCartSuccessBottomSheet(context, widget.product);
        }
        if (state is CartUpdateError) {
          _isLoading.value = false;
          CustomToast.error(message: "Failed to add in cart");
        }
      },
      builder: (context, state) {
        return BottomSheetWrapper(
          showTopDivider: true,
          widgetSpacing: 4,
          child: Container(
            padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product name
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Add to cart",
                        style: _theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close,
                            color: CustomTheme.lightGray, size: 24.0)),
                  ],
                ),
                Gap(16),

                // Quantity control
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('$quantity'),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.black54,
                          ),
                        ),
                        child: Icon(Icons.remove, color: Colors.black54),
                      ),
                    ),
                    Gap(8.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ],
                ),

                Divider(),
                Gap(24),

                // Buttons
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
                    ValueListenableBuilder(
                        valueListenable: _isLoading,
                        builder: (BuildContext context, value, Widget? child) {
                          return RoundedFilledButton(
                              textColor: Colors.white,
                              onPressed: () {
                                onAddToCart();
                              },
                              verticalPadding: 20,
                              title: "Add to cart",
                              backgroundColor: Colors.black,
                              borderColor: Colors.white);
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
