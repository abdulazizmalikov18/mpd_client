import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapObjectModel {
  final List<MapObject> mapObjects;
  final Point point;

  YandexMapObjectModel({required this.point, required this.mapObjects});
}
