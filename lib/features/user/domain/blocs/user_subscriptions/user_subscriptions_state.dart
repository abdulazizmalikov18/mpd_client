part of 'user_subscriptions_bloc.dart';

abstract class UserSubscriptionsState extends Equatable {
  final List<Subscription> subscriptions;
  final bool hasReachedMax;
  final bool isSearch;
  const UserSubscriptionsState(
      {this.subscriptions = const [],
      this.hasReachedMax = false,
      this.isSearch = false});

  @override
  List<Object?> get props => [subscriptions, hasReachedMax];
}

class UserSubscriptionsInitial extends UserSubscriptionsState {}

class UserSubscriptionsSuccess extends UserSubscriptionsState {
  const UserSubscriptionsSuccess(
      {required super.subscriptions, super.hasReachedMax, super.isSearch});
}

class UserSubscriptionsFailure extends UserSubscriptionsState {
  final String failure;
  const UserSubscriptionsFailure(
      {required this.failure, super.subscriptions, super.hasReachedMax});
}
