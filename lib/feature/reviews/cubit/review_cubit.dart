import 'package:bloc/bloc.dart';
import 'package:shoesly/common/bloc/data_state.dart';
import 'package:shoesly/common/http/response.dart';
import 'package:shoesly/feature/reviews/model/review_model.dart';
import 'package:shoesly/feature/reviews/repository/firebase_review_repo.dart';

class ReviewCubit extends Cubit<DataState> {
  ReviewCubit({required this.firebaseReviewRepository}) : super(StateInitial());
  final FirebaseReviewRepository firebaseReviewRepository;

  List<Review> _dataList = [];

  int _offset = 1;
  int _limit = 20;

  // addReview() async {
  //  await firebaseReviewRepository.createReview();
  // }

  fetchReviewList({
    bool isRefresh = false,
   required int productId,
   int? limit,
   double? rating,
  }) async {
    firebaseReviewRepository.clearReview();
    emit(StateLoading());
    final res = await firebaseReviewRepository.fetchReviews(
      offset: _offset,
      limit: limit?? _limit,
      productId: productId,
      rating: rating
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

  loadMoreReviews({
   required int productId,
   double? rating,
  }) async {
    emit(StateLoadingMoreData(data: _dataList));
    _offset++;
    final res = await firebaseReviewRepository.fetchReviews(
      limit: _limit,
      offset: _offset,
      productId: productId,
      rating: rating
    );

    if (res.status == Status.Success) {
      print(res.data);
      _dataList.addAll(res.data!);
      firebaseReviewRepository.insertAllReviewInMap(res.data!);
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
}
