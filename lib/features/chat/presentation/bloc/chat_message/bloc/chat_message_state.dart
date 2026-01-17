part of 'chat_message_bloc.dart';

class ChatMessageState extends Equatable {
  final List<MessageModel> messages;
  final int offset;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus sendMessageStatus;
  final int count;
  final String? currentGroupSlug;

  const ChatMessageState({
    this.messages = const [],
    this.status = FormzSubmissionStatus.initial,
    this.sendMessageStatus = FormzSubmissionStatus.initial,
    this.count = -1,
    this.offset = 0,
    this.currentGroupSlug,
  });

  @override
  List<Object?> get props => [
    messages,
    status,
    sendMessageStatus,
    count,
    offset,
    currentGroupSlug,
  ];

  ChatMessageState copyWith({
    List<MessageModel>? messages,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? sendMessageStatus,
    int? count,
    int? offset,
    String? currentGroupSlug,
  }) {
    return ChatMessageState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
      count: count ?? this.count,
      offset: offset ?? this.offset,
      currentGroupSlug: currentGroupSlug ?? this.currentGroupSlug,
    );
  }
}
