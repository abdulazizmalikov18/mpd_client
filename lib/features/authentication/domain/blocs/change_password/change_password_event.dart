part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class CheckPasswordAndChange extends ChangePasswordEvent {}

class OnlyCheckPasswordEvent extends ChangePasswordEvent {}

class MakeVisibleNewPassword extends ChangePasswordEvent {}

class MakeVisibleConfirmPassword extends ChangePasswordEvent {}
