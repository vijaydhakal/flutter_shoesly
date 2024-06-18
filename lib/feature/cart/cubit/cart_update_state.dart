import 'package:equatable/equatable.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';

abstract class CartUpdateState extends Equatable {
  const CartUpdateState();
  @override
  List<Object> get props => [];
}

class CartUpdateInitial extends CartUpdateState {
  @override
  List<Object> get props => [];
}

class CartUpdateLoading extends CartUpdateState {
  @override
  List<Object> get props => [];
}

class CartUpdateSuccess extends CartUpdateState {
  final String? successMessage;
  final CartItemModel? cart;
  const CartUpdateSuccess(
      {this.successMessage,
      this.cart,});
  @override
  List<Object> get props =>
      [successMessage ?? '',];
}

class CartUpdateError extends CartUpdateState {
  final String message;
  final CartItemModel? cart;
  CartUpdateError({
    required this.message,
    this.cart,
  });
  @override
  List<Object> get props => [message];
}
