
import 'message.dart';

class BaseMessage {
  final int? count;
  final String? next;
  final int? nextOffset;
  final int? previousOffset;
  final String? previous;
  final List<MessageModel> results;



  const BaseMessage({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    required this.results,
  });

  Map<String, Object?> toJson() {
    return {
      'count': count,
      'next': next,
      'next_offset': nextOffset,
      'previous_offset': previousOffset,
      'previous': previous,
      'results': results,
    };
  }

  factory BaseMessage.fromJson(Map<String, Object?> json) {
    return BaseMessage(
      count: json['count'] as int?,
      next: json['next'] as String?,
      nextOffset: json['next_offset'] as int?,
      previousOffset: json['previous_offset'] as int?,
      previous: json['previous'] as String?,
      results: json['results']!= null ? (json['results'] as List).map((e) => MessageModel.fromJson(e)).toList() : [],
    );
  }

  @override
  String toString() {
    return 'BaseMessage{count: $count, next: $next, nextOffset: $nextOffset, previousOffset: $previousOffset, previous: $previous, results: $results}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseMessage &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          next == other.next &&
          nextOffset == other.nextOffset &&
          previousOffset == other.previousOffset &&
          previous == other.previous &&
          results == other.results;

  @override
  int get hashCode =>
      count.hashCode ^
      next.hashCode ^
      nextOffset.hashCode ^
      previousOffset.hashCode ^
      previous.hashCode ^
      results.hashCode;

  BaseMessage copyWith({
    int? count,
    String? next,
    int? nextOffset,
    int? previousOffset,
    String? previous,
    List<MessageModel>? results,
  }) {
    return BaseMessage(
      count: count ?? this.count,
      next: next ?? this.next,
      nextOffset: nextOffset ?? this.nextOffset,
      previousOffset: previousOffset ?? this.previousOffset,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}


