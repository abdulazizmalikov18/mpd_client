part of 'user_profile_bloc.dart';

sealed class UserProfileEvent {}


class GetUserEvent extends UserProfileEvent{
  final String username;

  GetUserEvent({required this.username});
}