import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/features/home/data/models/local_service_model.dart';
import 'package:mpd_client/features/home/data/models/product_filter_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';

part 'product_specalist_event.dart';
part 'product_specalist_state.dart';

class ProductSpecalistBloc
    extends Bloc<ProductSpecalistEvent, ProductSpecalistState> {
  final HomeRepository _homeRepository;
  ProductSpecalistBloc(this._homeRepository)
      : super(const ProductSpecalistState()) {
    on<InsertProductEvent>(_onInsertProduct);
    on<IncrementProductEvent>(_onIncrementProduct);
    on<DicrementProductEvent>(_onDicrementProduct);
    on<GetProductSpecalistEvent>(_onGetProductSpecalist);
    on<GetProductOfferingEvent>(_onGetProductOffering);
  }

  Future<void> _onGetProductOffering(GetProductOfferingEvent event,
      Emitter<ProductSpecalistState> emit) async {
    if (!event.isMore) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
    final model = ProductFilterModel(
      limit: 20,
      org: "mpd",
      productType: 1,
      offset: event.isMore ? state.specialistProducts.length : 0,
    );
    final result = await _homeRepository.getSpecialistProducts(model);

    if (result.isRight) {
      emit(state.copyWith(
        specialistProducts: event.isMore
            ? [...state.specialistProducts, ...result.right.results]
            : result.right.results,
        count: result.right.count,
        status: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onGetProductSpecalist(GetProductSpecalistEvent event,
      Emitter<ProductSpecalistState> emit) async {
    if (!event.isMore) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
    final model = ProductFilterModel(
      specialist: event.specialistId,
      limit: 20,
      org: "mpd",
      offset: event.isMore ? state.specialistProducts.length : 0,
    );
    final result = await _homeRepository.getSpecialistProducts(model);

    if (result.isRight) {
      emit(state.copyWith(
        specialistProducts: event.isMore
            ? [...state.specialistProducts, ...result.right.results]
            : result.right.results,
        count: result.right.count,
        status: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void _onInsertProduct(
      InsertProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    if (state.localProducts
        .where((element) => element.id == event.specialistProduct.id)
        .isNotEmpty) {
      localProducts
          .removeWhere((element) => element.id == event.specialistProduct.id);
    } else {
      localProducts.add(LocalService.format(event.specialistProduct));
    }

    emit(state.copyWith(localProducts: localProducts, flas: !state.flas));
  }

  void _onIncrementProduct(
      IncrementProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    for (var el in localProducts) {
      if (el.id == event.id) {
        el.count += event.count;
      }
    }
    emit(state.copyWith(flas: !state.flas, localProducts: localProducts));
  }

  void _onDicrementProduct(
      DicrementProductEvent event, Emitter<ProductSpecalistState> emit) {
    List<LocalService> localProducts = List.from(state.localProducts);
    LocalService selectedDicrement =
        localProducts.singleWhere((e) => e.id == event.id);
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
