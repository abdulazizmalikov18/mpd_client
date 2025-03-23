import 'package:equatable/equatable.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/data/models/adverts_model.dart';

part 'adverticement_event.dart';
part 'adverticement_state.dart';

class AdverticementBloc extends Bloc<AdverticementEvent, AdverticementState> {
  AdverticementBloc(this._homeRepository)
      : super(const AdverticementInitial(adverts: [])) {
    on<GetAdvertsEvent>(_onGetAdverts);
  }

  final HomeRepository _homeRepository;
  final List<Adverticement> _adverts = [];
  final int _limit = 10;
  int _offset = 0;

  Future<void> _onGetAdverts(
      GetAdvertsEvent event, Emitter<AdverticementState> emit) async {
    if (state.isEnd) return;
    if (state is AdverticementLoading) return;
    emit(AdverticementLoading(adverts: state.adverts));

    final result =
        await _homeRepository.getAdverts(limit: _limit, offset: _offset);
    if (result.isRight) {
      _addOffset(result.right);
      emit(AdverticementSuccess(
          adverts: _adverts, isEnd: _adverts.length < _offset));
    } else {
      emit(AdverticementFailure(
          adverts: state.adverts,
          failure: Utils.errorFormat(result.left.message)));
    }
  }

  void _addOffset(AdvertsModel r) {
    _offset += 20;
    _adverts.addAll(r.results!);
  }
}
