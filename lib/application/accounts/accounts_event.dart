part of 'accounts_bloc.dart';

sealed class AccountsEvent {
  const AccountsEvent();
}

class GetRegion extends AccountsEvent {
  final int index;
  final int id;
  final String? search;

  const GetRegion({
    this.index = 0,
    this.id = 0,
    this.search,
  });
}

class GetProfession extends AccountsEvent {
  final int index;
  final int id;
  final String? search;

  const GetProfession({
    this.index = 0,
    this.id = 0,
    this.search,
  });
}

class GetAccountUserEvent extends AccountsEvent {
  final void Function()? onSuccess;
  final void Function(String errorMessage)? onError;

  const GetAccountUserEvent({this.onSuccess, this.onError});
}

class UpdateUserEvent extends AccountsEvent {
  final UserModel user;
  final String? avatar;
  final void Function() onSuccess;
  final void Function(String errorMessage) onError;

  UpdateUserEvent({
    required this.user,
    this.avatar,
    required this.onSuccess,
    required this.onError,
  });
}
