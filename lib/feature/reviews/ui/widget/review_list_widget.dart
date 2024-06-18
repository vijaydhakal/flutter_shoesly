import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/error/no_data_widget.dart';
import 'package:shoesly/common/widget/loading_overlay.dart';
import 'package:shoesly/common/widget/toast.dart';
import 'package:shoesly/feature/cart/ui/widget/common_list_view.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/reviews/cubit/review_cubit.dart';
import 'package:shoesly/feature/reviews/model/review_model.dart';
import 'package:shoesly/feature/reviews/ui/widget/rating_horizontal_list.dart';
import 'package:shoesly/feature/reviews/ui/widget/review_list_item.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ReviewListWidget extends StatefulWidget {
  ReviewListWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final int productId;

  @override
  _ReviewListWidgetState createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {
  List<double> ratings = [
    0.0,
    0.5,
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0
  ];

  final RefreshController refreshController = RefreshController();

  bool _isLoadMoreEnabled = true;
  bool _isRefreshing = false;
  bool isLoadMoreActive = false;
  bool _isLoading = false;
  String? querySlug;

  _loadMore(BuildContext context) {
    context.read<ReviewCubit>().loadMoreReviews(
          productId: widget.productId,
        );
  }

  _turnOffloading() {
    isLoadMoreActive = false;
    _isRefreshing = false;
    _isLoading = false;
    setState(() {});
  }

  String selectedRating = '';

  changeSelectedCategory(BuildContext context, selectedItem) {
    selectedRating = selectedItem;
    if (selectedItem == "All") {
      context.read<ReviewCubit>().fetchReviewList(
            productId: widget.productId,
          );
    } else {
      context.read<ReviewCubit>().fetchReviewList(
          productId: widget.productId, rating: double.tryParse(selectedItem)!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(
          "Reviews",
          bgColor: Colors.white,
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
          child: BlocConsumer<ReviewCubit, DataState>(
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
                return Center(child: CircularProgressIndicator());
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
                            SliverPinnedHeader(
                              child: RatingHorizontalList(
                                categories: List.generate(
                                    ratings.length,
                                    (index) => CategoryModel(
                                        id: index,
                                        title: ratings[index].toString(),
                                        imageUrl: ''))
                                  ..insert(
                                      0,
                                      CategoryModel(
                                          title: "All", id: -1, imageUrl: '')),
                                onClick: (value) {
                                  setState(() {
                                    changeSelectedCategory(context, value);
                                  });
                                },
                                selectedItem: selectedRating,
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(height: 50.hp),
                            )
                          ],
                        ),
                      ),
                    ];
                  },
                  body: CommonListview(
                    refreshController: refreshController,
                    items: state.data,
                    onRefresh: () {},
                    loadMore: () => _loadMore(context),
                    itemBuilder: (context, index) {
                      Review _item = state.data[index];
                      return ReviewListItem(
                        item: _item,
                      );
                    },
                    isLoadMoreActive: _isRefreshing,
                    loadMoreEnabled: _isLoadMoreEnabled,
                  ),
                );
              } else if (state is StateNoData) {
                return NoDataWidget();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
