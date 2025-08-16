part of 'sub_professions_bloc.dart';

abstract class SubProfessionsState {
  final List<Profession> subProfessions;
  final bool isEnd;

  final Profession? selectedSubProfession;
  final int oldParent;
  const SubProfessionsState({
    required this.subProfessions,
    this.isEnd = false,
    this.oldParent = -1,
    required this.selectedSubProfession,
  });
}

class SubProfessionsInitial extends SubProfessionsState {
  const SubProfessionsInitial({
    required super.subProfessions,
    required super.selectedSubProfession,
  });
}

class SubProfessionsLoading extends SubProfessionsState {
  const SubProfessionsLoading({
    required super.subProfessions,
    super.oldParent,
    required super.selectedSubProfession,
  });
}

class SubProfessionsLoaded extends SubProfessionsState {
  const SubProfessionsLoaded({
    required super.subProfessions,
    super.isEnd,
    super.oldParent,
    required super.selectedSubProfession,
  });
}

class SubProfessionsFailure extends SubProfessionsState {
  final String error;
  const SubProfessionsFailure({
    required super.subProfessions,
    required this.error,
    required super.selectedSubProfession,
  });
}
