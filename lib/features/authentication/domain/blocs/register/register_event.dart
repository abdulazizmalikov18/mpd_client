part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PrivacyReatPressed extends RegisterEvent {}

class AccountDisabled extends RegisterEvent {
  final VoidCallback onSucces;
  final VoidCallback onError;

  const AccountDisabled({required this.onSucces, required this.onError});
}

class RegisterButtonPressed extends RegisterEvent {}
