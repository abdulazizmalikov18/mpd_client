import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mpd_client/core/exceptions/failures.dart';
import 'package:mpd_client/features/user/data/models/user_subscriptions_model.dart';
import 'package:mpd_client/features/user/data/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'user_subscriptions_event.dart';
part 'user_subscriptions_state.dart';

class UserSubscriptionsBloc
    extends Bloc<UserSubscriptionsEvent, UserSubscriptionsState> {
  UserSubscriptionsBloc(this._userRepository, this.searchController)
      : super(UserSubscriptionsInitial()) {
    on<GetUserSubscriptionsEvent>(_onGetUserSubscriptions,
        transformer: droppable());

    on<InsertSubscription>(_onInsertSubscription);

    on<CloseSubscriptionBloc>(_onCloseSubscription);
    on<SearchSubscriptionsEvent>(
      _onSearchSubscriptions,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 250))
            .asyncExpand(mapper);
      },
    );
  }

  final UserRepository _userRepository;
  final List<Subscription> _subscriptions = [];
  final TextEditingController searchController;
  int subscriptionCount = 0;

  final int _limit = 5;
  int _offset = 0;

  void _onCloseSubscription(
      CloseSubscriptionBloc event, Emitter<UserSubscriptionsState> emit) {
    _subscriptions.clear();
    emit(UserSubscriptionsInitial());
  }

  void _onInsertSubscription(
      InsertSubscription event, Emitter<UserSubscriptionsState> emit) {
    if (event.isSubscribed) subscriptionCount += 1;
    if (!event.isSubscribed) {
      subscriptionCount -= 1;
    }
    emit(UserSubscriptionsSuccess(
        subscriptions: [..._subscriptions],
        hasReachedMax: _subscriptions.length < _offset));
  }

  Future<void> _onGetUserSubscriptions(GetUserSubscriptionsEvent event,
      Emitter<UserSubscriptionsState> emit) async {
    if (state.hasReachedMax && !event.isRefresh) return;

    if (event.isRefresh) _offset = 0;

    // Here, Getting professions first time
    if (state is UserSubscriptionsInitial) {
      final result = await _userRepository.getUserSubscriptions(
          limit: _limit, offset: _offset);
      if (result.isRight) {
        _offset += 5;
        _subscriptions.addAll(result.right.results!);
        subscriptionCount = result.right.count!;
        emit(UserSubscriptionsSuccess(
            subscriptions: result.right.results!,
            hasReachedMax: result.right.results!.length < _offset));
      } else {
        errorChecker(result.left, emit);
      }
    }

    // Here, Getting retailed professions with pagination
    final result = await _userRepository.getUserSubscriptions(
        limit: _limit, offset: event.isRefresh ? 0 : _offset);
    if (result.isRight) {
      if (event.isRefresh) {
        _offset = 0;
        _subscriptions.clear();
      }
      _offset += 5;
      _subscriptions.addAll(result.right.results!);

      emit(UserSubscriptionsSuccess(
          hasReachedMax: _subscriptions.length < _offset,
          subscriptions: [..._subscriptions]));
    } else {
      errorChecker(result.left, emit);
    }
  }

  void errorChecker(Failure failure, Emitter<UserSubscriptionsState> emit) {
    if (failure is NetworkFailure) {
      emit(UserSubscriptionsFailure(
          subscriptions: state.subscriptions, failure: failure.message));
    } else {
      emit(UserSubscriptionsFailure(
          subscriptions: state.subscriptions, failure: 'Server failure'));
    }
  }

  Future<void> _onSearchSubscriptions(SearchSubscriptionsEvent event,
      Emitter<UserSubscriptionsState> emit) async {
    if (event.query.length < 4) {
      emit(UserSubscriptionsSuccess(
          hasReachedMax: _subscriptions.length < _offset,
          isSearch: false,
          subscriptions: [..._subscriptions]));
      return;
    }
    if (state.hasReachedMax) {
      final searchingResult = _subscriptions
          .where((element) => (element.name! + element.lastname!)
              .toLowerCase()
              .contains(event.query.toLowerCase()))
          .toList();
      emit(UserSubscriptionsSuccess(
          subscriptions: searchingResult,
          hasReachedMax: _subscriptions.length < _offset,
          isSearch: true));
      return;
    }
    emit(UserSubscriptionsInitial());
    // Here, Getting professions first time
    final result =
        await _userRepository.getUserSubscriptions(query: event.query);
    if (result.isRight) {
      emit(UserSubscriptionsSuccess(
          subscriptions: result.right.results!,
          hasReachedMax: true,
          isSearch: true));
    } else {
      errorChecker(result.left, emit);
    }
  }
}
