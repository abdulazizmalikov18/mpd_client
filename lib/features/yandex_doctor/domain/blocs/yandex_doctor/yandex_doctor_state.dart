part of 'yandex_doctor_bloc.dart';

class YandexDoctorState {
  final bool isMoved;
  final Point? location;
  final List<MapObject> mapObjects;
  final String failure;
  final bool showDoctorInfo;
  final MapSpecialist? specialist;
  final double zoom;
  const YandexDoctorState(
      {required this.location,
      required this.mapObjects,
      this.failure = '',
      this.isMoved = false,
      this.showDoctorInfo = false,
      this.specialist,
      this.zoom = 9});

  YandexDoctorState copyWith(
      final Point? location, final List<MapObject>? mapObjects,
      {final String? failure,
      final bool? isMoved,
      final bool? showDoctorInfo,
      final MapSpecialist? specialist,
      final double? zoom}) {
    return YandexDoctorState(
        mapObjects: mapObjects ?? this.mapObjects,
        location: location ?? this.location,
        failure: failure ?? this.failure,
        isMoved: isMoved ?? this.isMoved,
        showDoctorInfo: showDoctorInfo ?? this.showDoctorInfo,
        specialist: specialist ?? this.specialist,
        zoom: zoom ?? this.zoom);
  }
}
