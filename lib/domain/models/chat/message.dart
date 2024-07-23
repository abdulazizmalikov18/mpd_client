
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

class MessageModel {
  final int? id;
  final String? sendId;
  final String? text;
  final String? groupSlug;
  final String? date;
  final String? file;
  final String? sender;
  final bool isRead;
  final bool isMe;
  final bool isSend;
  final bool isLocalFile;

  const MessageModel({
    this.id,
    this.text,
    this.groupSlug,
    this.date,
    this.file,
    this.sender,
    required this.isMe,
    required this.isSend,
    this.sendId,
    required this.isLocalFile,
    required this.isRead,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'text': text,
      'group_slug': groupSlug,
      'date': date,
      'file': file,
      'sender': sender,
    };
  }

  factory MessageModel.fromJson(Map<String, Object?> json) {
    return MessageModel(
      id: json['id'] as int?,
      text: json['text'] != null ? json['text'] as String : null,
      groupSlug: json['group_slug'] as String?,
      date: json['date'] as String?,
      file: json['file'] as String?,
      sender: json['sender'] as String?,
      isMe: json['sender'] == StorageRepository.getString(StorageKeys.USERNAME),
      isSend: true,
      isLocalFile: false,
      isRead: json['is_read'] as bool,
    );
  }

  factory MessageModel.fromSocket(Map<String, Object?> json) {
    return MessageModel(
      id: json['id'] as int?,
      text: json['text'] != null ? json['text'] as String : null,
      groupSlug: json['slug_name'] as String?,
      date: json['date'] as String?,
      file: json['file'] as String?,
      sender: json['sender'] as String?,
      isMe: json['sender'] == StorageRepository.getString(StorageKeys.USERNAME),
      isRead : json['isRead'] as bool? ?? false,
      isSend: true,
      isLocalFile: false,
    );
  }

  @override
  String toString() {
    return 'Message{id: $id, text: $text, groupSlug: $groupSlug, date: $date, sender: $sender, isMe: $isMe, isSend: $isSend}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sendId == other.sendId &&
          text == other.text &&
          groupSlug == other.groupSlug &&
          date == other.date &&
          file == other.file &&
          sender == other.sender &&
          isRead == other.isRead &&
          isMe == other.isMe &&
          isSend == other.isSend &&
          isLocalFile == other.isLocalFile;

  @override
  int get hashCode =>
      id.hashCode ^ sendId.hashCode ^ text.hashCode ^ groupSlug.hashCode ^ date.hashCode ^ file.hashCode ^ sender.hashCode ^ isRead.hashCode ^ isMe.hashCode ^ isSend.hashCode ^ isLocalFile.hashCode;
}
