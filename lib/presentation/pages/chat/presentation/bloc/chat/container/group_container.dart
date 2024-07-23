import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/models/chat/chat_group.dart';

class GroupContainer extends Equatable {
  final ChatGroupModel? activeGroup;
  final List<ChatGroupModel> groups;
  final FormzSubmissionStatus status;

  const GroupContainer({
    this.activeGroup,
    this.groups = const [],
    this.status = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
        activeGroup,
        groups,
        status,
      ];

  GroupContainer copyWith({
    ChatGroupModel? activeGroup,
    List<ChatGroupModel>? groups,
    FormzSubmissionStatus? status,
  }) {
    return GroupContainer(
      activeGroup: activeGroup ?? this.activeGroup,
      groups: groups ?? this.groups,
      status: status ?? this.status,
    );
  }
}
