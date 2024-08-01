import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';

class LocalService {
  int id, count;
  double price;
  final String name;
  final String? image;

  LocalService({
    required this.id,
    required this.price,
    required this.name,
    required this.image,
    required this.count,
  });

  LocalService copyWith(final int count) => LocalService(
        id: id,
        name: name,
        image: image,
        count: count,
        price: price,
      );

  static LocalService format(SpecialistProduct specialistProduct) {
    return LocalService(
      id: specialistProduct.id,
      price: specialistProduct.price.isEmpty ? 0 : specialistProduct.price.first.value,
      name: specialistProduct.product.name,
      image: "",
      count: 1,
    );
  }
}
