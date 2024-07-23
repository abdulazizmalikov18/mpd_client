import 'package:mpd_client/domain/models/chat/chat_group.dart';

class ChatGroupsResponse {
  int? count;
  String? next;
  int? nextOffset;
  int? previousOffset;
  String? previous;
  List<ChatGroupModel>? results;

  ChatGroupsResponse({
    this.count,
    this.next,
    this.nextOffset,
    this.previousOffset,
    this.previous,
    this.results,
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

  factory ChatGroupsResponse.fromJson(Map<String, Object?> json) {
    return ChatGroupsResponse(
      count: json['count'] as int?,
      next: json['next'] as String?,
      nextOffset: json['next_offset'] as int?,
      previousOffset: json['previous_offset'] as int?,
      previous: json['previous'] as String?,
      results: json['results'] != null ? (json['results'] as List).map((e) => ChatGroupModel.fromJson(e)).toList() : [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatGroupsResponse &&
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

  @override
  String toString() {
    return 'ChatGroupsResponse{count: $count, next: $next, nextOffset: $nextOffset, previousOffset: $previousOffset, previous: $previous, results: $results}';
  }
}
