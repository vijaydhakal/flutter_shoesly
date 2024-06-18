import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/widget/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/feature/cart/ui/pages/cart_list_page.dart';
import 'package:shoesly/feature/product/model/product_model.dart';

//function to open bottomsheet
Future<void> openAddToCartSuccessBottomSheet(
    BuildContext context, Product product) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return AddToCartSuccessBottomSheet(product: product);
    },
  );
}

class AddToCartSuccessBottomSheet extends StatefulWidget {
  final Product product;

  const AddToCartSuccessBottomSheet({Key? key, required this.product})
      : super(key: key);

  @override
  State<AddToCartSuccessBottomSheet> createState() =>
      _AddToCartSuccessBottomSheetState();
}

class _AddToCartSuccessBottomSheetState
    extends State<AddToCartSuccessBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return BottomSheetWrapper(
      showTopDivider: false,
      child: Container(
        padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              child: Icon(
                Icons.check,
                color: Colors.black54,
                size: 50,
              ),
            ),
            Gap(12.0),
            Text(
              "Added to cart",
              style: _theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            Gap(12.0),
            Text(
              "Your item has been added to cart",
              style: _theme.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
              ),
            ),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedFilledButton(
                    textColor: Colors.black,
                    onPressed: () {
                      NavigationService.popUntilFirst();
                    },
                    verticalPadding: 20,
                    title: "Back Explore",
                    backgroundColor: Colors.white,
                    borderColor: Colors.black54),
                Gap(CustomTheme.symmetricHozPadding),
                RoundedFilledButton(
                    textColor: Colors.white,
                    onPressed: () {
                      NavigationService.popUntilFirst();
                      NavigationService.push(CartListPage());
                    },
                    verticalPadding: 20,
                    title: "To cart",
                    backgroundColor: Colors.black,
                    borderColor: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
