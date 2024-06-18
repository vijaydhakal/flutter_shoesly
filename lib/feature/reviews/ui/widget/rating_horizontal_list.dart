import 'package:flutter/material.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/product/ui/widget/category_item_widget.dart';

class RatingHorizontalList extends StatefulWidget {
  RatingHorizontalList({
    Key? key,
    required this.categories,
    required this.onClick,
    required this.selectedItem,
  }) : super(key: key);
  final List<CategoryModel> categories;
  final ValueChanged<String> onClick;
  final selectedItem;

  @override
  State<RatingHorizontalList> createState() =>
      _RatingHorizontalListState();
}

class _RatingHorizontalListState extends State<RatingHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.hp),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.categories.length,
              (index) => CategoryItemWidget(
                title: widget.categories[index].title,
                onTap: () {
                  widget.onClick(
                    widget.categories[index].title,
                  );
                  setState(() {});
                },
                isSelected:
                    widget.selectedItem == widget.categories[index].title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
