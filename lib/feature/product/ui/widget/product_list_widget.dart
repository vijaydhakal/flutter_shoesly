import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/util/log.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/button/button_with_leading_icon.dart';
import 'package:shoesly/common/widget/loading_overlay.dart';
import 'package:shoesly/common/widget/shimmer/product_shimmer.dart';
import 'package:shoesly/common/widget/toast.dart';
import 'package:shoesly/feature/cart/ui/pages/cart_list_page.dart';
import 'package:shoesly/feature/product/cubit/category_cubit.dart';
import 'package:shoesly/feature/product/cubit/product_cubit.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/product/ui/screen/product_categories_list.dart';
import 'package:shoesly/feature/product/ui/widget/product_filter_widget.dart';
import 'package:shoesly/feature/product/ui/widget/product_grid_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductListWidget extends StatefulWidget {
  ProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ProductListWidgetState createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final RefreshController refreshController = RefreshController();

  bool _isLoadMoreEnabled = true;
  bool isLoadMoreActive = false;
  bool _isLoading = false;
  String? querySlug;
  Timer? timer;

  _loadMore(BuildContext context) {
    context.read<ProductCubit>().loadMoreProducts(
          categoryId: '',
        );
  }

  _turnOffloading() {
    isLoadMoreActive = false;
    _isLoading = false;
    setState(() {});
  }

  int selectedCategoryIndex = -1;

  changeSelectedCategory(BuildContext context, selectedCatID) {
    if (selectedCategoryIndex == selectedCatID) {
      selectedCategoryIndex = -1;
      context.read<ProductCubit>().fetchProductList();
    } else {
      selectedCategoryIndex = selectedCatID;
      context.read<ProductCubit>().fetchProductList(categoryId: selectedCatID);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ButtonWithLeadingIcon(
            textColor: Colors.white,
            borderColor: CustomTheme.black,
            name: "Filter",
            width: 40.w,
            icon: Icons.filter_list,
            function: () {
              NavigationService.push(ProductFilterWidget());
            },
            backgroundColor: Colors.black,
            iconColor: Colors.white),
        appBar: buildAppBar(
          "Discover",
          bgColor: Colors.white,
          showBackButton: false,
          actions: [
            //make cart icon widget
            IconButton(
                onPressed: () {
                  NavigationService.push(CartListPage());
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ))
          ],
        ),
        body: BlocConsumer<ProductCubit, DataState>(
          buildWhen: (context, state) {
            if (state is StateLoading) {
              return false;
            } else {
              return true;
            }
          },
          listener: (context, state) {
            if (state is StateLoadingMoreData) {
              if (isLoadMoreActive == false) {
                isLoadMoreActive = true;
                setState(() {});
              }
            }
            if (state is StateDataFetchSuccess || state is StateNoData) {
              _turnOffloading();
            }
            if (state is StateError) {
              _turnOffloading();
              CustomToast.error(message: state.message);
            }
            if (state is StatePaginationNoMoreData) {
              _isLoadMoreEnabled = false;
              _turnOffloading();
            }
          },
          builder: (context, state) {
            if (state is StateLoading) {
              return ProductShimmer();
            } else if (state is StateError) {
              return Center(
                child: Text(
                  state.message,
                ),
              );
            } else if (state is StateDataFetchSuccess ||
                state is StateRefreshingData ||
                state is StateLoadingMoreData ||
                state is StatePaginationNoMoreData) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: MultiSliver(
                        children: [
                          BlocBuilder<CategoryCubit, DataState>(
                            builder: (context, stt) {
                              if (stt is StateDataFetchSuccess) {
                                return SliverPinnedHeader(
                                  child: CategoriesHorizontalList(
                                    categories:
                                        stt.data.cast<CategoryModel>().toList()
                                          ..insert(
                                              0,
                                              CategoryModel(
                                                  title: "All",
                                                  id: -1,
                                                  imageUrl: '')),
                                    onClick: (value) {
                                      setState(() {
                                        changeSelectedCategory(context, value);
                                      });
                                    },
                                    selectedCategoryID: selectedCategoryIndex,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(height: 50.hp),
                          )
                        ],
                      ),
                    ),
                  ];
                },
                body: ProductItemGridSection(
                  products: state.data.cast<Product>().toList(),
                  isLoadMoreActive: isLoadMoreActive,
                  isLoadMoreEnabled: _isLoadMoreEnabled,
                  loadMore: () => _loadMore(context),
                  refreshController: refreshController,
                ),
              );
            } else if (state is StateNoData) {
              return CustomScrollView(
                slivers: [
                  BlocBuilder<CategoryCubit, DataState>(
                    builder: (context, stt) {
                      if (stt is StateDataFetchSuccess) {
                        return SliverToBoxAdapter(
                          child: CategoriesHorizontalList(
                            categories: stt.data.cast<CategoryModel>().toList(),
                            onClick: (value) {
                              Log.e(
                                  "The selected data are: $value $selectedCategoryIndex");

                              setState(() {
                                changeSelectedCategory(context, value);
                              });
                            },
                            selectedCategoryID: selectedCategoryIndex,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SliverFillRemaining(
                    child: Text("No data found"),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
