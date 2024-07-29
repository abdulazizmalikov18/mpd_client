import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mpd_client/domain/models/yandex/searched_specialist_model.dart';
import 'package:mpd_client/infrastructure/services/yandex_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'yandex_doctor_event.dart';
part 'yandex_doctor_state.dart';

class YandexDoctorBloc extends Bloc<YandexDoctorEvent, YandexDoctorState> {
  YandexDoctorBloc(this._yandexService) : super(const YandexDoctorState(location: null, mapObjects: [])) {
    on<ClusterPlaceMarkEvent>(_onClusterizedPlaceMark);
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
    on<InsertSingleObjectEvent>(_onInsertSingleObject);
    on<PlaceImagetoLocationEvent>(_onPlaceImagetoLocation);
    on<PressedMapObjectEvent>(_onPressedMapObject);
    on<ShowDoctorInfo>(_onShowDoctorInfo);
  }

  final YandexService _yandexService;
  List<MapObject<dynamic>> mapObjects = [];
  List<MapSpecialist> singleMapSpecialist = [];

  void _onShowDoctorInfo(ShowDoctorInfo event, Emitter<YandexDoctorState> emit) {
    emit(state.copyWith(state.location, mapObjects, showDoctorInfo: event.showInfo, zoom: 12));
  }

  void _onPressedMapObject(PressedMapObjectEvent event, Emitter<YandexDoctorState> emit) {
    for (var specialist in event.specialists) {
      if (specialist.location?.latitude == event.point.latitude) {
        emit(state.copyWith(event.point, mapObjects, showDoctorInfo: true, specialist: specialist, zoom: 20));
      }
    }
  }

  void _onInsertSingleObject(InsertSingleObjectEvent event, Emitter<YandexDoctorState> emit) {
    final latitude = event.specialist.location?.latitude ?? 41.311015;
    final longitude = event.specialist.location?.longitude ?? 69.279760;

    final point = Point(latitude: latitude, longitude: longitude);

    if (point == state.location) {
      emit(state.copyWith(point, mapObjects, specialist: event.specialist, showDoctorInfo: true, zoom: 20));
      return;
    }
    singleMapSpecialist.add(event.specialist);
    final singPlacemark = _yandexService.getSinglePlacemark(
      point,
      '${event.specialist.id}',
      context: event.context,
      specialists: singleMapSpecialist,
    );

    mapObjects.add(singPlacemark);

    emit(state.copyWith(point, mapObjects, showDoctorInfo: true, specialist: event.specialist, zoom: 20));
  }

  void _onClusterizedPlaceMark(ClusterPlaceMarkEvent event, Emitter<YandexDoctorState> emit) async {
    final largeMapObject =
        await _yandexService.getClusterizedPlacemarks(specialists: event.specialists, context: event.context);
    mapObjects.removeWhere((el) => el.mapId == _yandexService.largeMapObjectId);
    mapObjects.add(largeMapObject);
    debugPrint("==========>>>>>>>> bu blocda ${largeMapObject.placemarks}");
    if (largeMapObject.placemarks.isNotEmpty) {
      emit(state.copyWith(largeMapObject.placemarks.first.point, mapObjects, zoom: 12));
    }
  }

  void _onGetCurrentLocation(GetCurrentLocationEvent event, Emitter<YandexDoctorState> emit) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return emit(state.copyWith(
        state.location,
        state.mapObjects,
        failure: 'Location service is not enabled in your device',
      ));
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return emit(state.copyWith(state.location, state.mapObjects, failure: 'Location permission is denied'));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return emit(state.copyWith(state.location, state.mapObjects,
          failure: 'Location permissions are permanently denied, we cannot request permissions.'));
    }

    final placeMarkObjects = await _yandexService.getCurrentPosition();

    mapObjects.removeWhere((element) => element is CircleMapObject);
    mapObjects.addAll(placeMarkObjects.mapObjects);

    emit(state.copyWith(placeMarkObjects.point, mapObjects, isMoved: true, showDoctorInfo: false, zoom: 14.5));
  }

  Future<void> _onPlaceImagetoLocation(PlaceImagetoLocationEvent event, Emitter<YandexDoctorState> emit) async {
    // for (var map in mapObjects) {
    //   if (map.mapId == const MapObjectId('me_${0}')) {
    //     await _addMyImageAndPlacemark((map as CircleMapObject).circle.center, event.imageMemory);
    //     break;
    //   }
    // }

    emit(state.copyWith(state.location, mapObjects, isMoved: false));
  }

  // Future<void> _addMyImageAndPlacemark(Point point, Uint8List? imageMemory) async {
  // final imagePlaceMark = await _yandexService.getMyImagePlaceMark(point: point, imageBytes: imageMemory);
  //   mapObjects.removeWhere((element) => element.mapId == _yandexService.userLocation);
  // mapObjects.add(imagePlaceMark);
  // }
}


/*
Future<void> _onPlaceImagetoLocation(
      PlaceImagetoLocationEvent event, Emitter<YandexDoctorState> emit) async {
    const imageUrl =
        'http://www.lib.uchicago.edu/efts/ARTFL/projects/mckee/Images/gavarni-reduced2.jpg';
    await _addMyImageAndPlacemark(event.point, imageUrl);
    print(
        'Location -------------- ${event.point} ---- ${mapObjects.length} ------ ${state.isMoved}');
    emit(state.copyWith(event.point, mapObjects, isMoved: false));
  }

  Future<void> _addMyImageAndPlacemark(Point point, String imageUrl) async {
    final imagePlaceMark =
        await _yandexService.getMyImagePlaceMark(point, imageUrl);
    mapObjects
        .removeWhere((element) => element.mapId == _yandexService.userLocation);
    mapObjects.add(imagePlaceMark);
  }


 */
