part of 'records_bloc.dart';

class RecordsState {
  final List<RecordModel> records;
  final bool hasReachedMax;
  final bool isSearch;
  final String failure;
  final FormzSubmissionStatus status;

  const RecordsState({
    this.records = const [],
    this.hasReachedMax = false,
    this.isSearch = false,
    this.failure = '',
    this.status = FormzSubmissionStatus.initial,
  });

  RecordsState copyWith({
    List<RecordModel>? records,
    bool? hasReachedMax,
    bool? isSearch,
    String? failure,
    FormzSubmissionStatus? status,
  }) {
    return RecordsState(
      records: records ?? this.records,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSearch: isSearch ?? this.isSearch,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordsState &&
          runtimeType == other.runtimeType &&
          records == other.records &&
          hasReachedMax == other.hasReachedMax &&
          isSearch == other.isSearch &&
          failure == other.failure &&
          status == other.status;

  @override
  int get hashCode => records.hashCode ^ hasReachedMax.hashCode ^ isSearch.hashCode ^ failure.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'RecordsState{records: $records, hasReachedMax: $hasReachedMax, isSearch: $isSearch, failure: $failure, status: $status}';
  }
}
