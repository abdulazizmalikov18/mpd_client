import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/models/doctor_booking/card_remote_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/doctor_profile_repository.dart';
part 'my_cards_event.dart';
part 'my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  MyCardsBloc(this._profileRepository) : super(const MyCardsInitial(cards: [], selectId: -1)) {
    on<GetMyCardsEvent>(_onGetMyCards);
    on<SelectCardEvent>(_onSelectCard);
    on<InsertCardToAllEvent>(_onInsertCard);
    on<SelectPaymentType>(_onSelectPayment);
  }

  final DoctorProfileRepository _profileRepository;

  void _onSelectCard(SelectCardEvent event, Emitter<MyCardsState> emit) {
    emit(MyCardsSuccess(cards: state.cards, selectId: event.selectedId));
  }

  void _onSelectPayment(SelectPaymentType event, Emitter<MyCardsState> emit) {
    emit(MyCardsSuccess(cards: state.cards, selectId: state.selectId, paymentMethod: event.paymentMethod));
  }

  void _onInsertCard(InsertCardToAllEvent event, Emitter<MyCardsState> emit) {
    final cards = state.cards;
    cards.add(event.card);
    emit(MyCardsSuccess(cards: cards, selectId: state.selectId));
  }

  Future<void> _onGetMyCards(GetMyCardsEvent event, Emitter<MyCardsState> emit) async {
    emit(MyCardsLoading(cards: state.cards, selectId: state.selectId));

    final result = await _profileRepository.getMyCards();
    if (result.isRight) {
      emit(MyCardsSuccess(cards: result.right, selectId: state.selectId));
    } else {
      emit(MyCardsFailure(result.left.errorMessage, cards: state.cards, selectId: state.selectId));
    }
  }
}
