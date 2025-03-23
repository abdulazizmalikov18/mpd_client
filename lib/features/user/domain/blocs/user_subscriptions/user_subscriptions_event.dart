part of 'user_subscriptions_bloc.dart';

abstract class UserSubscriptionsEvent extends Equatable {
  const UserSubscriptionsEvent();

  @override
  List<Object> get props => [];
}

class GetUserSubscriptionsEvent extends UserSubscriptionsEvent {
  final bool isRefresh, tryAgain;
  const GetUserSubscriptionsEvent(
      {this.isRefresh = false, this.tryAgain = false});
}

class InsertSubscription extends UserSubscriptionsEvent {
  final bool isSubscribed;
  const InsertSubscription(this.isSubscribed);
}

class SearchSubscriptionsEvent extends UserSubscriptionsEvent {
  final String query;
  const SearchSubscriptionsEvent(this.query);
}

class CloseSubscriptionBloc extends UserSubscriptionsEvent {}
