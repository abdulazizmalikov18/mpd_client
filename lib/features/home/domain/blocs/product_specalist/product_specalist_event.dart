part of 'product_specalist_bloc.dart';

sealed class ProductSpecalistEvent {}

class GetProductSpecalistEvent extends ProductSpecalistEvent {
  final int specialistId;
  final bool isMore;

  GetProductSpecalistEvent({
    required this.specialistId,
    this.isMore = false,
  });
}

class GetProductOfferingEvent extends ProductSpecalistEvent {
  final bool isMore;

  GetProductOfferingEvent({
    this.isMore = false,
  });
}

class InsertProductEvent extends ProductSpecalistEvent {
  final SpecialistProduct specialistProduct;
  InsertProductEvent(this.specialistProduct);
}

class IncrementProductEvent extends ProductSpecalistEvent {
  final int count, id;
  IncrementProductEvent({required this.id, required this.count});
}

class DicrementProductEvent extends ProductSpecalistEvent {
  final int count, id;
  DicrementProductEvent({required this.id, required this.count});
}
