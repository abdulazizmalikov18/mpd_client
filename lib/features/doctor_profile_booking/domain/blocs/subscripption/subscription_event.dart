part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class SetSubscribedOrNot extends SubscriptionEvent {
  final bool? followStatus;
  const SetSubscribedOrNot(this.followStatus);
}

class SubscribeToDrEvent extends SubscriptionEvent {
  final String username;
  const SubscribeToDrEvent(this.username);
}

class UnSubscribeToDrEvent extends SubscriptionEvent {
  final String username;
  const UnSubscribeToDrEvent(this.username);
}
