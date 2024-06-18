import 'package:flutter/material.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/product/ui/widget/category_item_widget.dart';

class CategoriesHorizontalList extends StatefulWidget {
  CategoriesHorizontalList({
    Key? key,
    required this.categories,
    required this.onClick,
    required this.selectedCategoryID,
  }) : super(key: key);
  final List<CategoryModel> categories;
  final ValueChanged<int> onClick;
  final selectedCategoryID;

  @override
  State<CategoriesHorizontalList> createState() =>
      _CategoriesHorizontalListState();
}

class _CategoriesHorizontalListState extends State<CategoriesHorizontalList> {
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
                    widget.categories[index].id,
                  );
                  setState(() {});
                },
                isSelected:
                    widget.selectedCategoryID == widget.categories[index].id,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
