part of 'sub_professions_bloc.dart';

abstract class SubProfessionsEvent extends Equatable {
  const SubProfessionsEvent();

  @override
  List<Object> get props => [];
}

class GetSubProfessionsEvent extends SubProfessionsEvent {
  final int parent;
  const GetSubProfessionsEvent({required this.parent});
}

class SelectSubProfessionEvent extends SubProfessionsEvent {
  final Profession selectedSubProfession;
  const SelectSubProfessionEvent({required this.selectedSubProfession});
}
