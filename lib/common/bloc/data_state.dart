import 'package:equatable/equatable.dart';

class DataState extends Equatable {
  final dynamic data;
  const DataState({this.data, this.filterId});
  final String? filterId;
  @override
  List<Object?> get props => [data, filterId];
}

class StateInitial extends DataState {}

class StateLoading extends DataState {}

class StateDummyLoading extends DataState {}

class StateError extends DataState {
  final String message;
  const StateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class StateNoData extends DataState {
  final dynamic data;
  const StateNoData({this.data});
  List<Object?> get props => [data];
}

class StateDataFetchSuccess extends DataState {
  final List data;
  const StateDataFetchSuccess({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StateDataFetchSuccessMap extends DataState {
  final List data;
  final String filterId;
  const StateDataFetchSuccessMap({required this.data, required this.filterId})
      : super(data: data, filterId: filterId);
  @override
  List<Object?> get props => [data, filterId];
}

class StateRefreshingData extends DataState {
  final List data;
  const StateRefreshingData({required this.data});
  @override
  List<Object?> get props => [...data];
}

class StateLoadingMoreData extends DataState {
  final List data;
  const StateLoadingMoreData({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StatePaginationNoMoreData extends DataState {
  final List data;
  const StatePaginationNoMoreData({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StateDataUpdatedFromScoket extends DataState {
  final List data;
  const StateDataUpdatedFromScoket({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StateLoadingMoreDataMap extends DataState {
  final List data;
  final String filterId;
  const StateLoadingMoreDataMap({required this.data, required this.filterId})
      : super(data: data, filterId: filterId);
  @override
  List<Object?> get props => [data, filterId];
}

class StateDataPostLoading extends DataState {
  @override
  List<Object?> get props => [];
}

class StateDataPostError extends DataState {
  @override
  List<Object?> get props => [];
}

class StateDataPostSuccess extends DataState {
  @override
  List<Object?> get props => [];
}
