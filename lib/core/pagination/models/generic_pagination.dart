import 'package:json_annotation/json_annotation.dart';

part 'generic_pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericPagination<T> {
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'next')
  final String? next;
  @JsonKey(name: 'next_offset')
  final int? nextOffset;
  @JsonKey(name: 'previous_offset')
  final int? previousOffset;
  @JsonKey(name: 'previous')
  final String? previous;
  @JsonKey(name: 'results')
  final List<T> results;

  GenericPagination({
    this.count = 0,
    this.next = '',
    this.nextOffset = 0,
    this.previousOffset = 0,
    this.previous = '',
    this.results = const [],
  });
  factory GenericPagination.fromJson(
          Map<String, dynamic> json, T Function(Object?) fetch) =>
      _$GenericPaginationFromJson(json, fetch);
}
