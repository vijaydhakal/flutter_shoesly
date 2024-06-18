import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/product/ui/screen/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        NavigationService.push(ProductDetailScreen(
          product: product,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color.fromARGB(255, 186, 183, 183),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  "https://t3.ftcdn.net/jpg/01/21/81/86/360_F_121818673_6EID5iF76VCCc4aGOLJkd94Phnggre3o.jpg",
                  height: 100.0,
                  width: 50.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${product.name}',
              style: _theme.textTheme.bodyMedium,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20.0),
                Gap(4),
                Text(
                  product.rating.toString(),
                  style: _theme.textTheme.bodySmall,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: _theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
