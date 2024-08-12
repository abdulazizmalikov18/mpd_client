import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/abstract_repo/lenta_repository.dart';
import 'package:mpd_client/domain/entity/generic_entity.dart';
import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';
import 'package:mpd_client/infrastructure/services/local_service.dart';

part 'product_specalist_event.dart';
part 'product_specalist_state.dart';

class ProductSpecalistBloc extends Bloc<ProductSpecalistEvent, ProductSpecalistState> {
  final LentaRepository _repo;
  ProductSpecalistBloc(this._repo) : super(const ProductSpecalistState()) {
    on<InsertProductEvent>(_onInsertProduct);
    on<IncrementProductEvent>(_onIncrementProduct);
    on<DicrementProductEvent>(_onDicrementProduct);
    on<GetProductSpecalistEvent>(_onGetProductSpecalist);
  }

  _onGetProductSpecalist(GetProductSpecalistEvent event, Emitter<ProductSpecalistState> emit) async {
    if (!event.isMore) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
    final result = await _repo.getSpecialistProducts(GenericEntity(
      data: event.specialistId,
      limit: 20,
      offset: event.isMore ? state.specialistProducts.length : 0,
    ));

    if (result.isRight) {
      emit(state.copyWith(
        specialistProducts: event.isMore ? [...state.specialistProducts, ...result.right.results] : result.right.results,
        count: result.right.count,
        status: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  _onInsertProduct(InsertProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    if (state.localProducts.where((element) => element.id == event.specialistProduct.id).isNotEmpty) {
      localProducts.removeWhere((element) => element.id == event.specialistProduct.id);
    } else {
      localProducts.add(LocalService.format(event.specialistProduct));
    }

    emit(state.copyWith(localProducts: localProducts, flas: !state.flas));
  }

  void _onIncrementProduct(IncrementProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    for (var el in localProducts) {
      if (el.id == event.id) {
        el.count += event.count;
      }
    }
    emit(state.copyWith(flas: !state.flas, localProducts: localProducts));
  }

  void _onDicrementProduct(DicrementProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    LocalService selectedDicrement = localProducts.singleWhere((e) => e.id == event.id);
    selectedDicrement.count -= event.count;

    if (selectedDicrement.count == 0) {
      localProducts.remove(selectedDicrement);
    }

    emit(state.copyWith(flas: !state.flas, localProducts: localProducts));
  }

  bool contains({required int id}) {
    for (LocalService e in state.localProducts) {
      if (e.id == id) {
        return true;
      }
    }
    return false;
  }
}
