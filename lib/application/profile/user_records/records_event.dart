part of 'records_bloc.dart';

abstract class RecordsEvent extends Equatable {
  const RecordsEvent();

  @override
  List<Object> get props => [];
}

class GetRecordsEvent extends RecordsEvent {
  final bool isRefresh;
  const GetRecordsEvent([this.isRefresh = false]);
}

class SearchRecordEvent extends RecordsEvent {
  final String query;
  const SearchRecordEvent(this.query);
}

class CancelSearchEvent extends RecordsEvent {}
