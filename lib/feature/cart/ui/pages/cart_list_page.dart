import 'package:flutter/cupertino.dart';
import 'package:shoesly/feature/cart/ui/widget/cart_list_widget.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({super.key});

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CartListWidget();
  }
}