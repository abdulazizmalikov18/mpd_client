
import 'package:mpd_client/domain/models/chat/message.dart';

class ChatContainer {
  final int? count;
  final String? next;
  final int? nextOffset;
  final List<MessageModel> chats;

  const ChatContainer({
    this.count,
    this.next,
    this.nextOffset,
    required this.chats,
  });

  ChatContainer copyWith({
    int? count,
    String? next,
    int? nextOffset,
    List<MessageModel>? chats,
  }) {
    return ChatContainer(
      count: count ?? this.count,
      next: next ?? this.next,
      nextOffset: nextOffset ?? this.nextOffset,
      chats: chats ?? this.chats,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatContainer &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          next == other.next &&
          nextOffset == other.nextOffset &&
          chats == other.chats;

  @override
  int get hashCode => count.hashCode ^ next.hashCode ^ nextOffset.hashCode ^ chats.hashCode;

  @override
  String toString() {
    return 'ChatContainer{count: $count, next: $next, nextOffset: $nextOffset, chats: $chats}';
  }
}
