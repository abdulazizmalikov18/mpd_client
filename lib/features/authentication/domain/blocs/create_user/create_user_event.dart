part of 'create_user_bloc.dart';

abstract class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class SelectingGenderEvent extends CreateUserEvent {
  final Gender gender;
  const SelectingGenderEvent(this.gender);
}

class SelectingBirthEvent extends CreateUserEvent {
  final DateTime dateTime;
  const SelectingBirthEvent(this.dateTime);
}

class ForCreateUserEvent extends CreateUserEvent {
  final int? mainCategory, region;
  final String phone, password;

  const ForCreateUserEvent({
    required this.phone,
    required this.password,
    this.mainCategory,
    this.region,
  });
}
