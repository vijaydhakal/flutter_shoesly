import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/feature/product/cubit/category_cubit.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/product/ui/widget/all_filter_wrapper.dart';

class ProductFilterWidget extends StatefulWidget {
  const ProductFilterWidget({super.key, this.function});
  final Function? function;

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  List<String> sortByList = [
    "Low to High",
    "High to Low",
    "Newest",
    "Oldest",
    "Relevancy"
  ];

  List<String> genderList = [
    "Men",
    "Women",
    "Unisex",
    "Kids",
    "All",
  ];

  List<String> colorList = [
    "FFFFFF",
    "234FFF",
    "FF0000",
    "0000FF",
    "00FF00",
    "FF00FF",
    "FFFF00",
    "00FFFF",
    "000000",
    "808080",
    "800000",
    "808000",
    "800080",
    "008000",
    "008080",
    "000080",
    "FFA500",
    "FFD700",
    "808000",
    "800080",
    "008000",
    "008080",
    "000080",
  ];

  String selectedGender = '';
  String selectedColor = '';
  int selectedCategory = -1;
  String selectedSortBy = "";

  int getFilterCount() {
    int count = 0;
    if (selectedGender.isNotEmpty) {
      count++;
    }
    if (selectedColor.isNotEmpty) {
      count++;
    }
    if (selectedCategory != -1) {
      count++;
    }
    if (selectedSortBy.isNotEmpty) {
      count++;
    }
    return count;
  }

  void clearFilter() {
    setState(() {
      selectedColor = '';
      selectedCategory = -1;
      selectedGender = '';
      selectedSortBy = '';
    });
  }

  void applyFilter() {
    widget.function!(
      selectedColor,
      selectedCategory,
      selectedGender,
      selectedSortBy,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = Theme.of(context).textTheme;
    final List<CategoryModel> categoryList =
        context.read<CategoryCubit>().getCategoriesList();
    return Scaffold(
      appBar: buildAppBar(
        "Filter",
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AllFilterWrapper(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                categoryList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RoundedFilledButton(
                    textColor: selectedCategory == categoryList[index].id
                        ? Colors.white
                        : CustomTheme.black,
                    onPressed: () {
                      setState(() {
                        selectedCategory = categoryList[index].id;
                      });
                    },
                    title: categoryList[index].title,
                    backgroundColor: selectedCategory == categoryList[index].id
                        ? Colors.black
                        : Colors.white,
                    borderColor: selectedCategory == categoryList[index].id
                        ? Colors.white
                        : Colors.black.withOpacity(.1),
                  ),
                ),
              )),
            ),
            title: "Brands"),
        AllFilterWrapper(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                sortByList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RoundedFilledButton(
                    textColor: selectedSortBy == sortByList[index]
                        ? Colors.white
                        : CustomTheme.black,
                    onPressed: () {
                      selectedSortBy = sortByList[index];
                      setState(() {});
                    },
                    title: sortByList[index],
                    backgroundColor: selectedSortBy == sortByList[index]
                        ? Colors.black
                        : Colors.white,
                    borderColor: selectedSortBy == sortByList[index]
                        ? Colors.white
                        : Colors.black.withOpacity(.1),
                  ),
                ),
              )),
            ),
            title: "Sort By"),
        AllFilterWrapper(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                colorList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RoundedFilledButton(
                    textColor: selectedColor == colorList[index]
                        ? Colors.white
                        : CustomTheme.black,
                    onPressed: () {
                      setState(() {
                        selectedColor = colorList[index];
                      });
                    },
                    title: colorList[index],
                    backgroundColor: selectedColor == colorList[index]
                        ? Colors.black
                        : Colors.white,
                    borderColor: selectedColor == colorList[index]
                        ? Colors.white
                        : Colors.black.withOpacity(.1),
                    child: Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Color(int.parse('FF' + colorList[index],
                                  radix: 16)),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black)),
                        ),
                        Gap(10),
                        Text(
                          colorList[index],
                          style: _textTheme.labelLarge!.copyWith(
                            color: selectedColor == colorList[index]
                                ? Colors.white
                                : CustomTheme.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
            title: "Color"),
        AllFilterWrapper(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                genderList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RoundedFilledButton(
                    textColor: selectedGender == genderList[index]
                        ? Colors.white
                        : CustomTheme.black,
                    onPressed: () {
                      selectedGender = genderList[index];
                      setState(() {});
                    },
                    title: genderList[index],
                    backgroundColor: selectedGender == genderList[index]
                        ? Colors.black
                        : Colors.white,
                    borderColor: selectedGender == genderList[index]
                        ? Colors.white
                        : Colors.black.withOpacity(.1),
                  ),
                ),
              )),
            ),
            title: "Gender"),
        Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Gap(20),
            Expanded(
              child: RoundedFilledButton(
                textColor: CustomTheme.black,
                onPressed: () {
                  clearFilter();
                },
                title: "Reset(${getFilterCount()})",
                backgroundColor: Colors.white,
                borderColor: Colors.black.withOpacity(.1),
              ),
            ),
            Gap(20),
            Expanded(
              child: RoundedFilledButton(
                  textColor: Colors.white,
                  onPressed: () {
                    applyFilter();
                  },
                  title: "Apply",
                  backgroundColor: Colors.black,
                  borderColor: Colors.white),
            ),
            Gap(20),
          ],
        ),
        Gap(20),
      ]),
    );
  }
}
