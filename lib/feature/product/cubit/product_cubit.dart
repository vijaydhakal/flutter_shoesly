import 'package:bloc/bloc.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/feature/product/model/product_model.dart';
import 'package:shoesly/feature/product/product_repository/firebase_product_repo.dart';

class ProductCubit extends Cubit<DataState> {
  ProductCubit({required this.firebaseProductRepository})
      : super(StateInitial());
  final FirebaseProductRepository firebaseProductRepository;

  List<Product> _dataList = [];

  int _offset = 1;
  int _limit = 20;

  fetchProductList(
    {
    bool isRefresh = false,
     int? categoryId,
  }
  ) async {
    firebaseProductRepository.clearProduct();
    emit(StateLoading());
    final res = await firebaseProductRepository.fetchProducts(
      offset: _offset,
      limit: _limit,
      categoryId: categoryId,
    );
    if (res.status == Status.Success && res.data!.isNotEmpty) {
      emit(StateDataFetchSuccess(data: res.data!));
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(StateDataFetchSuccess(data: []));
    }
  }

  loadMoreProducts({
     String? categoryId,
  }) async {
    emit(StateLoadingMoreData(data: _dataList));
    _offset++;
    final res = await firebaseProductRepository.fetchProducts(
      limit: _limit,
      offset: _offset,
    );

    if (res.status == Status.Success) {
      print(res.data);
      _dataList.addAll(res.data!);
      firebaseProductRepository.insertAllProductInMap(res.data!);
      if (res.data!.isEmpty || res.data!.length < _limit) {
        emit(StatePaginationNoMoreData(data: _dataList));
        return;
      } else {
        emit(StateDataFetchSuccess(data: _dataList));
      }
    }

    if (res.status == Status.Error) {
      emit(StatePaginationNoMoreData(data: _dataList));
      return;
    }
  }

  // updateProductCart({
  //   required bool inCart,
  //   required int productOrganizationId,
  //   required Cart? cart,
  // }) async {
  //   final res = await firebaseProductRepository.upateProductCart(
  //       inCart: inCart,
  //       productOrganizationId: productOrganizationId,
  //       cart: cart,);
  //   emit(StateDummyLoading());
  //   emit(StateDataFetchSuccess(data: res.data!));
  // }
}
