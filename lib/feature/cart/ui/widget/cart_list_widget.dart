import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/common/widget/loading_overlay.dart';
import 'package:shoesly/common/widget/toast.dart';
import 'package:shoesly/feature/cart/cubit/cart_list_cubit.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_cubit.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_state.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';
import 'package:shoesly/feature/cart/ui/widget/cart_item_delete_dialog.dart';
import 'package:shoesly/feature/cart/ui/widget/cart_list_item.dart';
import 'package:shoesly/feature/cart/ui/widget/common_list_view.dart';
import 'package:shoesly/feature/cart/ui/widget/order_summary_widget.dart';
import 'package:shoesly/feature/product/cubit/product_cubit.dart';

class CartListWidget extends StatefulWidget {
  const CartListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CartListWidgetState createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();

    refreshController = RefreshController();
    fetchOrRefresh(context: context);
  }

  fetchOrRefresh({bool isRefresh = false, required BuildContext context}) {
    context.read<CartListCubit>().fetchCartList();
  }

  bool _isRefreshing = false;
  bool _isLoadingMoreData = false;
  bool _isLoadMoreEnabled = true;

  _loadMore(BuildContext context) {
    context.read<CartListCubit>().loadMoreCarts();
  }

  _turnOffloading() {
    _isLoadingMoreData = false;
    _isRefreshing = false;
    setState(() {});
  }

//make checkbox
  bool _isLoading = false;

  String _productTotalPrice = "";

  __getProductTotalPrice(List<CartItemModel> cartItems) {
    _productTotalPrice = "";
    double _temp = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      _temp = _temp +
          double.parse((cartItems[i].price * cartItems[i].quantity).toString());
    }
    _productTotalPrice = _temp.toString();
  }

  _onDelete(BuildContext ctx, CartItemModel cart) {
    showDialog<dynamic>(
      context: context,
      builder: (_) {
        return CartItemDeleteDialog(
            onTrue: (val) {
              if (val == true) {
                ctx.read<CartUpdateCubit>().deleteCart(
                      cart: cart,
                    );
              }
            },
            isLoading: _isLoading);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _txt = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _theme.scaffoldBackgroundColor,
      appBar: buildAppBar(
        "Cart",
        bgColor: Colors.white,
      ),
      body: BlocConsumer<CartListCubit, DataState>(
        listener: (context, state) {
          if (state is StateLoadingMoreData) {
            if (_isLoadingMoreData == false) {
              _isLoadingMoreData = true;
              setState(() {});
            }
          }
          if (state is StateDataFetchSuccess) {
            _turnOffloading();
          }
          if (state is StateError) {
            _turnOffloading();
            CustomToast.error(message: "Error occured");
          }
          if (state is StatePaginationNoMoreData) {
            _isLoadMoreEnabled = false;
            _turnOffloading();
          }
        },
        builder: (context, state) {
          if (state is StateLoading || state is StateInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateNoData) {
            return Center(
              child: Text("Cart is empty"),
            );
          } else if (state is StateDataFetchSuccess ||
              state is StateRefreshingData ||
              state is StateLoadingMoreData ||
              state is StatePaginationNoMoreData) {
            __getProductTotalPrice(state.data);
            return LoadingOverlay(
              isLoading: _isLoading,
              child: Column(
                children: [
                  Flexible(
                    child: CommonListview(
                      refreshController: refreshController,
                      items: state.data,
                      onRefresh: () {},
                      loadMore: () => _loadMore(context),
                      itemBuilder: (context, index) {
                        CartItemModel _item = state.data[index];
                        return CartListItem(
                          cart: _item,
                          onDelete: () => _onDelete(context, _item),
                        );
                      },
                      isLoadMoreActive: _isLoadingMoreData,
                      loadMoreEnabled: _isLoadMoreEnabled,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.hp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        BlocConsumer<CartUpdateCubit, CartUpdateState>(
                          listener: (context, st) {
                            if (st is CartUpdateLoading) {
                              _isLoading = true;
                              setState(() {});
                            }
                            if (st is CartUpdateSuccess) {
                              _isLoading = false;
                              setState(() {});
                              CustomToast.success(
                                  message: st.successMessage ?? "Success");
                              context.read<CartListCubit>().refreshCart();
                            } else if (st is CartUpdateError) {
                              setState(() {});

                              CustomToast.error(message: st.message);

                              _isLoading = false;
                            }
                          },
                          builder: (context, st) {
                            return AbsorbPointer(
                                absorbing: _isLoading,
                                child: // Buttons
                                    Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Price',
                                            style: _theme.textTheme.titleMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Text(
                                            '\$${_productTotalPrice}',
                                            style: _theme.textTheme.titleMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ]),
                                    Gap(CustomTheme.symmetricHozPadding),
                                    RoundedFilledButton(
                                        isLoading: _isLoading,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          NavigationService.push(
                                              OrderSummaryWidget(
                                            cartItems: state.data,
                                          ));
                                        },
                                        verticalPadding: 20,
                                        title: "Checkout",
                                        backgroundColor: Colors.black,
                                        borderColor: Colors.white),
                                  ],
                                ));
                          },
                        ),
                        SizedBox(height: 8.hp),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
