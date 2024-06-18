import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/widget/app_bar/build_appbar.dart';
import 'package:shoesly/common/widget/button/rounded_filled_button.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key, required this.cartItems});
  final List<CartItemModel> cartItems;
  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  String _productTotalPrice = "";

  __getProductTotalPrice(List<CartItemModel> cartItems) {
    _productTotalPrice = "";
    double _temp = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      _temp = _temp +
          double.parse((cartItems[i].price * cartItems[i].quantity).toString());
    }
    _productTotalPrice = _temp.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    __getProductTotalPrice(widget.cartItems);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar("Order Summary"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Information',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Payment Method',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    'Credit Card',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Location',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    'Semarang, Indonesia',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Order Detail',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Column(
                  children: List.generate(
                    widget.cartItems.length,
                    (index) => ListTile(
                      title: Text(
                        widget.cartItems[index].productInfo.name,
                        style: _theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        'Qty ${widget.cartItems[index].quantity}',
                        style: _theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      trailing: Text(
                        '\$${widget.cartItems[index].price}',
                        style: _theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Payment Detail',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Subtotal',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: Text(
                    '\$${_productTotalPrice}',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Grand Total',
                      style: _theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '\$${_productTotalPrice}',
                      style: _theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ]),
              Gap(CustomTheme.symmetricHozPadding),
              RoundedFilledButton(
                  textColor: Colors.white,
                  onPressed: () {},
                  verticalPadding: 20,
                  title: "Payment",
                  backgroundColor: Colors.black,
                  borderColor: Colors.white),
            ],
          ),
        ]),
      ),
    );
  }
}
