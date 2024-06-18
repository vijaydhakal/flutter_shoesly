import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonGridView extends StatelessWidget {
  CommonGridView({
    Key? key,
    required this.isLoadMoreActive,
    required this.isLoadMoreEnabled,
    required this.loadMore,
    this.refreshController,
    required this.desiredItemWidth,
    required this.onRefresh,
    required this.itemBuilder,
    required this.itemCount,
    this.mainAxisExtent = 230,
  }) : super(key: key);
  final bool isLoadMoreActive;
  final bool isLoadMoreEnabled;
  final Function loadMore;
  final Function onRefresh;
  RefreshController? refreshController;
  final double desiredItemWidth;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double mainAxisExtent;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (scrollDetails) {
        if (scrollDetails is UserScrollNotification) {
          //
          if (scrollDetails.metrics.pixels >
              scrollDetails.metrics.maxScrollExtent / 2) {
            //
            if (scrollDetails.direction == ScrollDirection.reverse &&
                isLoadMoreActive == false &&
                isLoadMoreEnabled) {
              loadMore();
            }
          }
        }
        return true;
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: mainAxisExtent,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
