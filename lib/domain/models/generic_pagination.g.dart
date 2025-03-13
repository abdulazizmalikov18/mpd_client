// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericPagination<T> _$GenericPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    GenericPagination<T>(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String? ?? '',
      nextOffset: (json['next_offset'] as num?)?.toInt() ?? 0,
      previousOffset: (json['previous_offset'] as num?)?.toInt() ?? 0,
      previous: json['previous'] as String? ?? '',
      results: (json['results'] as List<dynamic>?)?.map(fromJsonT).toList() ??
          const [],
    );
