part of 'check_username_bloc.dart';

abstract class CheckUsernameEvent extends Equatable {
  const CheckUsernameEvent();

  @override
  List<Object> get props => [];
}

class CheckUsername extends CheckUsernameEvent {
  final String username;
  const CheckUsername(this.username);
}
