// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_specalist_bloc.dart';

class ProductSpecalistState extends Equatable {
  final List<SpecialistProduct> specialistProducts;
  final FormzSubmissionStatus status;
  final int count;
  final List<LocalService> localProducts;
  final bool flas;

  const ProductSpecalistState({
    this.specialistProducts = const [],
    this.status = FormzSubmissionStatus.initial,
    this.count = 0,
    this.localProducts = const [],
    this.flas = false,
  });

  @override
  List<Object> get props => [
        specialistProducts,
        status,
        count,
        localProducts,
        flas,
      ];

  ProductSpecalistState copyWith({
    List<SpecialistProduct>? specialistProducts,
    FormzSubmissionStatus? status,
    int? count,
    List<LocalService>? localProducts,
    bool? flas,
  }) {
    return ProductSpecalistState(
      specialistProducts: specialistProducts ?? this.specialistProducts,
      status: status ?? this.status,
      count: count ?? this.count,
      localProducts: localProducts ?? this.localProducts,
      flas: flas ?? this.flas,
    );
  }
}
