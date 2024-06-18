

import 'package:bloc/bloc.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/feature/cart/model/cart_item_model.dart';
import 'package:shoesly/feature/cart/repository/firebase_cart_repo.dart';
class CartListCubit extends Cubit<DataState> {
  CartListCubit(
      {required this.cartRepository})
      : super(StateInitial());
  FirebaseCartRepository cartRepository;
  List<CartItemModel> _dataList = [];

  int _offset = 1;
  int _limit = 20;

  fetchCartList(
      {
      bool isRefresh = false,}) async {
    emit(StateLoading());
    final res = await cartRepository.fetchCart(limit: _limit);
      _dataList = <CartItemModel>[];
    if (res.status == Status.Success && res.data!.isNotEmpty) {
      _dataList.addAll(res.data!);
      cartRepository.insertAllCartInMap(res.data!);
      emit(StateDataFetchSuccess(data: _dataList));
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(StateNoData());
    }
  }

  loadMoreCarts() async {
    emit(StateLoadingMoreData(data: _dataList));

    _offset++;
    final res = await cartRepository.fetchCart(
       limit: _limit, offset: _offset);

    if (res.status == Status.Success) {
      _dataList.addAll(res.data!);
      cartRepository.insertAllCartInMap(res.data!);

      if (res.data!.isEmpty || res.data!.length < _limit) {
        emit(StatePaginationNoMoreData(data: _dataList));
        return;
      }
    }

    if (res.status == Status.Error) {
      emit(StatePaginationNoMoreData(data: _dataList));
      return;
    }

    emit(StateDataFetchSuccess(data: _dataList));
  }

    refreshCart() async {
    final res = await cartRepository.fetchCart(
        limit: _limit);

    if (res.status == Status.Success && res.data!.isNotEmpty) {
      emit(StateDataFetchSuccess(data: res.data!));
      _dataList.addAll(res.data!);
      cartRepository.insertAllCartInMap(res.data!);
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(StateNoData());
    }
  }

  removefromCart({
    required int cartId,
  }) async {
    final res = await cartRepository.removeCartItemModel(
      cartId: cartId,
    );
    if (res.status == Status.Success && res.data!.isNotEmpty) {
      emit(StateDataFetchSuccess(data: res.data!));
      _dataList.addAll(res.data!);
      cartRepository.insertAllCartInMap(res.data!);
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(StateNoData());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
