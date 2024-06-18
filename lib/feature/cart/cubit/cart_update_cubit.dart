import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/feature/cart/cubit/cart_update_state.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';
import 'package:shoesly/feature/cart/repository/firebase_cart_repo.dart';

class CartUpdateCubit extends Cubit<CartUpdateState> {
  CartUpdateCubit({required this.cartRepository}) : super(CartUpdateInitial());

  FirebaseCartRepository cartRepository;

  updateQuantity({required CartItemModel cart}) async {
    emit(CartUpdateLoading());
    final res = await cartRepository.updateCartItemModel(cart);

    if (res.status == Status.Success) {
      emit(
        CartUpdateSuccess(
          successMessage: res.message,
          cart: cart,
        ),
      );
    } else if (res.status == Status.Error) {
      emit(CartUpdateError(
        message: res.message!,
        cart: cart,
      ));
    }
  }

  deleteCart({
    required CartItemModel cart,
  }) async {
    emit(CartUpdateLoading());
    final res = await cartRepository.removeCartItemModel(cartId: cart.id);
    if (res.status == Status.Success) {
      emit(
        CartUpdateSuccess(
          successMessage: res.message,
          cart: null,
        ),
      );
    } else if (res.status == Status.Error) {
      emit(
        CartUpdateError(
          message: res.message!,
          cart: cart,
        ),
      );
    }
  }

  addCart({required CartItemModel cart}) async {
    emit(CartUpdateLoading());
    final res = await cartRepository.addCartItemModel(cart);

    if (res.status == Status.Success) {
      if (res.data != null) cart = res.data;
      emit(
        CartUpdateSuccess(
          successMessage: res.message,
          cart: cart,
        ),
      );
    } else if (res.status == Status.Error) {
      emit(CartUpdateError(
        message: res.message!,
        cart: cart,
      ));
    }
  }
}
