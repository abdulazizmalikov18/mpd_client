import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/models/doctor_booking/user_subscription_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
import 'package:mpd_client/utils/utils.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc(this._profileRepository) : super(const SubscriptionInitial(false)) {
    on<SetSubscribedOrNot>(_onSetSubcribedOrNot);

    on<SubscribeToDrEvent>(_onSubscribeToDrEvent);
    on<UnSubscribeToDrEvent>(_onUnSubscribeToDrEvent);
  }

  final DoctorProfileRepository _profileRepository;

  void _onSetSubcribedOrNot(SetSubscribedOrNot event, Emitter<SubscriptionState> emit) {
    emit(SubscriptionInitial(event.followStatus != null ? event.followStatus! : false));
  }

  Future<void> _onSubscribeToDrEvent(SubscribeToDrEvent event, Emitter<SubscriptionState> emit) async {
    emit(const SubscriptionLoading(true));

    final result = await _profileRepository.subscribeToDoctor(event.username);
    if (result.isRight) {
      emit(SubscriptionSuccess(state.isSubscribed, subscription: result.right));
    } else {
      emit(SubscriptionFailure(Utils.errorFormat(result.left.errorMessage), false));
    }
  }

  Future<void> _onUnSubscribeToDrEvent(UnSubscribeToDrEvent event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading(false, subscription: state.subscription));

    final result = await _profileRepository.deleteSubscription(event.username);
    if (result.isRight) {
      emit(SubscriptionSuccess(state.isSubscribed, subscription: null));
    } else {
      emit(SubscriptionFailure(Utils.errorFormat(result.left.errorMessage), true, subscription: state.subscription));
    }
  }
}
