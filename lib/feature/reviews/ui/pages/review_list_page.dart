
import 'package:flutter/material.dart';
import 'package:shoesly/feature/reviews/ui/widget/review_list_widget.dart';

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({super.key, required this.productId});
  final int productId;

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  @override
  Widget build(BuildContext context) {
    return ReviewListWidget(
      productId: widget.productId,
    );
  }
}
