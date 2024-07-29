part of 'yandex_doctor_bloc.dart';

abstract class YandexDoctorEvent extends Equatable {
  const YandexDoctorEvent();

  @override
  List<Object> get props => [];
}

class ClusterPlaceMarkEvent extends YandexDoctorEvent {
  final List<MapSpecialist> specialists;
  final BuildContext context;
  const ClusterPlaceMarkEvent(
      {required this.specialists, required this.context});
}

class InsertSingleObjectEvent extends YandexDoctorEvent {
  final MapSpecialist specialist;
  final BuildContext context;
  const InsertSingleObjectEvent(
      {required this.specialist, required this.context});
}

class GetCurrentLocationEvent extends YandexDoctorEvent {}

class PlaceImagetoLocationEvent extends YandexDoctorEvent {
  final Uint8List? imageMemory;
  const PlaceImagetoLocationEvent({this.imageMemory});
}

class PressedMapObjectEvent extends YandexDoctorEvent {
  final Point point;
  final List<MapSpecialist> specialists;
  const PressedMapObjectEvent(this.point, {required this.specialists});
}

class ShowDoctorInfo extends YandexDoctorEvent {
  final bool showInfo;
  const ShowDoctorInfo(this.showInfo);
}

class AddMapObjectsEvent extends YandexDoctorEvent {
  final BuildContext context;
  const AddMapObjectsEvent(this.context);
}
