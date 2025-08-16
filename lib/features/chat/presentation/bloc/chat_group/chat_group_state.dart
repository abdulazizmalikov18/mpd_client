part of 'chat_group_bloc.dart';

class ChatGroupState extends Equatable {
  final List<ChatGroupModel> groups;
  final FormzSubmissionStatus status;
  final int count;
  final int offset;

  const ChatGroupState({
    this.groups = const [],
    this.status = FormzSubmissionStatus.initial,
    this.count = -1,
    this.offset = -1,
  });

  @override
  List<Object?> get props => [groups, status, count, offset];

  ChatGroupState copyWith({
    List<ChatGroupModel>? groups,
    FormzSubmissionStatus? status,
    int? count,
    int? offset,
  }) {
    return ChatGroupState(
      groups: groups ?? this.groups,
      status: status ?? this.status,
      count: count ?? this.count,
      offset: offset ?? this.offset,
    );
  }
}
