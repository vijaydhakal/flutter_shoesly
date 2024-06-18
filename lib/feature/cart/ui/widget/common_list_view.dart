import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/bounce_loader.dart';
import 'package:shoesly/common/widget/error/no_data_widget.dart';

typedef ListItemCallback<T> = Widget Function(BuildContext context, int index);

class CommonListview extends StatelessWidget {
  const CommonListview({
    Key? key,
    required this.refreshController,
    this.noDataWidget,
    required this.items,
    required this.onRefresh,
    this.loadMoreEnabled = true,
    required this.loadMore,
    this.isLoadMoreActive = false,
    required this.itemBuilder,
    this.hasSmartRefresh = true,
  }) : super(key: key);
  final RefreshController refreshController;
  final Widget? noDataWidget;
  final List items;
  final ListItemCallback itemBuilder;
  final Function onRefresh;
  final Function loadMore;
  final bool isLoadMoreActive;
  final bool loadMoreEnabled;
  final bool hasSmartRefresh;

  Widget _buildBody() {
    if (items.length == 0) {
      return SingleChildScrollView(
          child: Center(
        child: noDataWidget ?? NoDataWidget(),
      ));
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollDetails) {
          if (scrollDetails is UserScrollNotification) {
            //
            if (scrollDetails.metrics.pixels >
                scrollDetails.metrics.maxScrollExtent / 2) {
              //
              if (scrollDetails.direction == ScrollDirection.reverse &&
                  isLoadMoreActive == false &&
                  loadMoreEnabled) {
                loadMore();
              }
            }
          }
          return true;
        },
        child: ListView.builder(
            itemCount:
                items.length + (loadMoreEnabled && isLoadMoreActive ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == items.length && isLoadMoreActive) {
                return Center(
                  child: BounceLoader(
                      size: 25.wp, color: CustomTheme.primaryColor),
                );
              } else
                return itemBuilder(context, index);
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return hasSmartRefresh
        ? SmartRefresher(
            controller: refreshController,

            enablePullDown: true,
            // onRefresh: () => onRefresh(),
            onRefresh: () {
              print("called on refresh");
            },
            child: _buildBody(),
          )
        : _buildBody();
  }
}
