

import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/shimmer/shimmer_container.dart';
import 'package:shoesly/common/widget/shimmer/shimmer_wrapper.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return ShimmerWrapper(
      child: Container(
        margin: EdgeInsets.only(
            bottom: 8,
            left: CustomTheme.symmetricHozPadding.hp,
            right: CustomTheme.symmetricHozPadding.hp),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            childAspectRatio: (_width * 0.3) / 130,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ShimmerContainer(
                  height: 85,
                  width: null,
                ),
                ShimmerContainer(
                  height: 10,
                  width: null,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
