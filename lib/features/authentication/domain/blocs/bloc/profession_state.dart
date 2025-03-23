part of 'profession_bloc.dart';

abstract class ProfessionState extends Equatable {
  final List<Profession> professions;
  final bool hasReachedMax;
  final Profession? chosenProfession;
  const ProfessionState(
      {this.professions = const [],
      this.hasReachedMax = false,
      this.chosenProfession});

  @override
  List<Object?> get props => [professions, hasReachedMax, chosenProfession];
}

class ProfessionInitial extends ProfessionState {}

class ProfessionSuccess extends ProfessionState {
  const ProfessionSuccess(
      {super.professions, super.hasReachedMax, super.chosenProfession});
}

class ProfessionFailure extends ProfessionState {
  final String failure;
  const ProfessionFailure(
      {super.professions,
      required this.failure,
      super.hasReachedMax,
      super.chosenProfession});
}
