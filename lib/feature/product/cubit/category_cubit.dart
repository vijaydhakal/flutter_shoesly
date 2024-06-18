import 'package:bloc/bloc.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/feature/product/model/category_model.dart';
import 'package:shoesly/feature/product/product_repository/category_repo.dart';

class CategoryCubit extends Cubit<DataState> {
  CategoryCubit({required this.categoryRepository}) : super(StateInitial());
  final CategoryRepository categoryRepository;

  //add data to database

  // addCategory() async {
  //   final res = await categoryRepository.addCategory();
  //   print(res);
  // }

  //fetch data from database
  fetchCategory() async {
    emit(StateLoading());
    final res = await categoryRepository.fetchCategory();
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

  //fetch category from repository
 getCategoriesList(){
   return categoryRepository.getCategories;
  }
}
