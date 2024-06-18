import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_cubit.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';

class CartListItem extends StatefulWidget {
  const CartListItem({super.key, required this.cart, this.onDelete});
  final CartItemModel cart;
  final Function? onDelete;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
            onPressed: (value) {
              widget.onDelete!();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color.fromARGB(255, 186, 183, 183),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  "https://t3.ftcdn.net/jpg/01/21/81/86/360_F_121818673_6EID5iF76VCCc4aGOLJkd94Phnggre3o.jpg",
                  height: 100.0,
                  width: 25.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.cart.productInfo.name}',
                    style: _theme.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${widget.cart.productInfo.price}',
                          style: _theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (widget.cart.quantity > 1) {
                                context.read<CartUpdateCubit>().updateQuantity(
                                    cart: widget.cart.cloneWith(
                                        quantity: widget.cart.quantity - 1));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.black54,
                                ),
                              ),
                              child: Icon(Icons.remove, color: Colors.black54),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('${widget.cart.quantity}'),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CartUpdateCubit>().updateQuantity(
                                  cart: widget.cart.cloneWith(
                                      quantity: widget.cart.quantity + 1));
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Icon(Icons.add, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
