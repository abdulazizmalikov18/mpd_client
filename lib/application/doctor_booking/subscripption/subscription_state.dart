part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  final bool isSubscribed;
  final Subscription? subscription;
  const SubscriptionState(this.isSubscribed, {this.subscription});

  @override
  List<Object?> get props => [isSubscribed, subscription];
}

class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial(super.isSubscribed, {super.subscription});
}

class SubscriptionLoading extends SubscriptionState {
  const SubscriptionLoading(super.isSubscribed, {super.subscription});
}

class SubscriptionSuccess extends SubscriptionState {
  const SubscriptionSuccess(super.isSubscribed, {super.subscription});
}

class SubscriptionFailure extends SubscriptionState {
  final String failure;
  const SubscriptionFailure(this.failure, super.isSubscribed, {super.subscription});
}
