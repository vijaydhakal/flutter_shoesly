import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/common/widget/toast.dart';
import 'package:shoesly/feature/reviews/cubit/review_cubit.dart';
import 'package:shoesly/feature/reviews/ui/pages/review_list_page.dart';
import 'package:shoesly/feature/reviews/ui/widget/review_list_item.dart';

class ReviewWidgetProductDetail extends StatefulWidget {
  const ReviewWidgetProductDetail({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final int productId;

  @override
  _ReviewWidgetProductDetailState createState() =>
      _ReviewWidgetProductDetailState();
}

class _ReviewWidgetProductDetailState extends State<ReviewWidgetProductDetail> {
  @override
  void initState() {
    super.initState();
    fetchOrRefresh(context: context);
  }

  fetchOrRefresh({bool isRefresh = false, required BuildContext context}) {
    context.read<ReviewCubit>().fetchReviewList(
          productId: widget.productId,
          limit: 10,
        );
  }

  bool _isLoadingMoreData = false;

  _turnOffloading() {
    _isLoadingMoreData = false;
    setState(() {});
  }

//make checkbox
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _txt = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;
    return BlocConsumer<ReviewCubit, DataState>(
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
          _turnOffloading();
        }
      },
      builder: (context, state) {
        if (state is StateLoading || state is StateInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is StateNoData) {
          return Container();
        } else if (state is StateDataFetchSuccess ||
            state is StateRefreshingData ||
            state is StateLoadingMoreData ||
            state is StatePaginationNoMoreData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Text(
                'Reviews',
                style: _theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ]
              ..addAll(List.generate(
                state.data.length,
                (index) => ReviewListItem(
                  item: state.data[index],
                ),
              ))
              ..add(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedFilledButton(
                      textColor: Colors.black,
                      onPressed: () {
                        NavigationService.push(ReviewListPage(
                          productId: widget.productId,
                        ));
                      },
                      verticalPadding: 20,
                      title: "See All Review ",
                      backgroundColor: Colors.white,
                      borderColor: Colors.black54),
                ),
              )
              ..add(Gap(36)),
          );
        }
        return Container();
      },
    );
  }
}
