import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mpd_client/presentation/pages/yandex_doctor/data/models/searched_specialist_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../application/yandex/yandex_doctor/yandex_doctor_bloc.dart';

abstract class IYandexService {
  Future<ClusterizedPlacemarkCollection> getClusterizedPlacemarks({required List<MapSpecialist> specialists, required BuildContext context});

  Future<YandexMapObjectModel> getCurrentPosition();
}

class YandexService extends IYandexService {
  Completer<YandexMapController> yandexController = Completer();

  GlobalKey mapKey = GlobalKey();
  List<MapSpecialist> noNullspecialists = [];

  String? imageUrl;

  final MapObjectId largeMapObjectId = const MapObjectId('large_clusterized_placemark_collection');
  final MapObjectId userLocation = const MapObjectId('user_location');

  List<CircleMapObject> _myCirclePlacemarks = [];

  final Point initialPoint = const Point(latitude: 41.311081, longitude: 69.240562);
  // const Point(latitude: 41.310733, longitude: 69.251167);

  final animation = const MapAnimation(type: MapAnimationType.smooth, duration: 1.0);

  final int kPlacemarkCount = 500;
  final Random seed = Random();

  @override
  Future<YandexMapObjectModel> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final YandexMapObjectModel placemarkMapObjects = _getPlaceMark(position: position);
    return placemarkMapObjects;
  }

  // @override
  // Future<ClusterizedPlacemarkCollection> getClusterizedPlacemarks(
  //     {required BuildContext context}) async {
  //   final largeMapObject = ClusterizedPlacemarkCollection(
  //       mapId: largeMapObjectId,
  //       radius: 30,
  //       minZoom: 15,
  //       onClusterAdded:
  //           (ClusterizedPlacemarkCollection self, Cluster cluster) async {
  //         return cluster.copyWith(
  //             appearance: cluster.appearance.copyWith(
  //                 opacity: 0.75,
  //                 icon: PlacemarkIcon.single(PlacemarkIconStyle(
  //                     image: BitmapDescriptor.fromBytes(
  //                         await _buildClusterAppearance(cluster)),
  //                     scale: 1))));
  //       },
  //       onClusterTap: (ClusterizedPlacemarkCollection self, Cluster cluster) {
  //         print('Tapped cluster');
  //       },
  //       placemarks: List<PlacemarkMapObject>.generate(kPlacemarkCount, (i) {
  //         return PlacemarkMapObject(
  //             mapId: MapObjectId('placemark_$i'),
  //             point: Point(
  //                 latitude: 55.756 + _randomDouble(),
  //                 longitude: 37.618 + _randomDouble()),
  //             icon: PlacemarkIcon.single(PlacemarkIconStyle(
  //                 image: BitmapDescriptor.fromAssetImage(AppImages.placeMark),
  //                 scale: 1)));
  //       }),
  //       onTap: (ClusterizedPlacemarkCollection self, Point point) =>
  //           context.read<YandexDoctorBloc>().add(PressedMapObjectEvent(point)));
  //   return largeMapObject;
  // }

  @override
  Future<ClusterizedPlacemarkCollection> getClusterizedPlacemarks({required List<MapSpecialist> specialists, required BuildContext context}) async {
    final largeMapObject = ClusterizedPlacemarkCollection(
      mapId: largeMapObjectId,
      radius: 30,
      minZoom: 15,
      onClusterAdded: (ClusterizedPlacemarkCollection self, Cluster cluster) async {
        return cluster.copyWith(
          appearance: cluster.appearance.copyWith(
            opacity: 0.75,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(await _buildClusterAppearance(cluster)), scale: 1),
            ),
          ),
        );
      },
      placemarks: _getListPlacemarks(context, specialists: specialists),
    );
    return largeMapObject;
  }

  // For clustirized map objects
  Future<Uint8List> _buildClusterAppearance(Cluster cluster) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(200, 200);
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.yellow.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    const radius = 60.0;

    final textPainter = TextPainter(text: TextSpan(text: cluster.size.toString(), style: const TextStyle(color: Colors.black, fontSize: 50)), textDirection: TextDirection.ltr);

    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final textOffset = Offset((size.width - textPainter.width) / 2, (size.height - textPainter.height) / 2);
    final circleOffset = Offset(size.height / 2, size.width / 2);

    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    textPainter.paint(canvas, textOffset);

    final image = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  YandexMapObjectModel _getPlaceMark({Position? position, Point? point}) {
    if (position != null) {
      point = positionToPoint(position);
    }

    if (_myCirclePlacemarks.isEmpty) {
      _myCirclePlacemarks = List<CircleMapObject>.generate(2, (i) {
        return CircleMapObject(
          mapId: MapObjectId('me_$i'),
          zIndex: i.toDouble(),
          circle: Circle(center: point!, radius: 100 * (i + 1)),
          strokeWidth: 0,
          fillColor: const Color(0xFF3E80FF).withOpacity(0.3),
        );
      });
    }

    return YandexMapObjectModel(point: point!, mapObjects: _myCirclePlacemarks);
  }

  List<PlacemarkMapObject> _getListPlacemarks(BuildContext context, {required List<MapSpecialist> specialists}) {
    List<PlacemarkMapObject> placemarks = [];
    noNullspecialists.clear();

    for (var i = 0; i < specialists.length; i++) {
      if (specialists[i].location != null) {
        final Point point = Point(
          latitude: specialists[i].location?.latitude ?? 41.311015,
          longitude: specialists[i].location?.longitude ?? 69.279760,
        );
        final placeMark = PlacemarkMapObject(
          mapId: MapObjectId('placemark_$i'),
          point: point,
          onTap: (mapObject, point) {
            context.read<YandexDoctorBloc>().add(PressedMapObjectEvent(mapObject.point, specialists: noNullspecialists));
          },
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppImages.placeMark), scale: 0.7),
          ),
        );
        placemarks.add(placeMark);
        noNullspecialists.add(specialists[i]);
      }
    }
    return placemarks;
  }

  PlacemarkMapObject getSinglePlacemark(Point point, String specialistId, {required BuildContext context, required List<MapSpecialist> specialists}) {
    final singlePlaceMark = PlacemarkMapObject(
        mapId: MapObjectId(specialistId),
        point: point,
        onTap: (mapObject, point) {
          context.read<YandexDoctorBloc>().add(PressedMapObjectEvent(mapObject.point, specialists: specialists));
        },
        icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppImages.placeMark), scale: 0.7)));
    return singlePlaceMark;
  }

  // Future<PlacemarkMapObject> getMyImagePlaceMark({required Point point, Uint8List? imageBytes}) async {
  //   if (imageBytes == null) {
  //     final placemark = PlacemarkMapObject(
  //         mapId: userLocation,
  //         point: point,
  //         icon: PlacemarkIcon.single(
  //             PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage(AppIcons.mapProfileDefault))));

  //     return placemark;
  //   }
  //   Uint8List? resizedImage;
  //   if (_userImageBytes != imageBytes || _userImageBytes == null) {
  //     _userImageBytes = imageBytes;
  //     resizedImage = await ImageCropper().resizeAndCircleFromMemory(_userImageBytes!, 120);
  //   }
  //   final placemark = PlacemarkMapObject(
  //       mapId: userLocation,
  //       point: point,
  //       opacity: 0.7,
  //       icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(resizedImage!))));

  //   return placemark;
  // }

  // Future<PlacemarkMapObject> getUrlImagePlaceMark(Point point, String imageUrl) async {
  //   Uint8List? imageBytes;
  //   if (this.imageUrl != imageUrl || this.imageUrl == null) {
  //     this.imageUrl = imageUrl;
  //     debugPrint("========>>>>>>> $imageUrl");
  //     imageBytes = await _getImageFromNetwork(this.imageUrl!);
  //   }
  //   final placemark = PlacemarkMapObject(
  //       mapId: userLocation,
  //       point: point,
  //       opacity: 0.7,
  //       icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromBytes(imageBytes!))));

  //   return placemark;
  // }

  Future<void> moveCameraPosition(Point point, {double zoom = 10}) async {
    (await yandexController.future).moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: point, zoom: zoom)), animation: animation);
  }

  // Future<Uint8List> _getImageFromNetwork(String imageUrl) async {
  //   Uint8List imageNetwork = await ImageCropper().resizeAndCircle(imageUrl, 120);
  //   return imageNetwork;
  // }

  //'https://pbs.twimg.com/profile_images/1141781661551665153/BMnvVd2u_400x400.jpg'

  Point positionToPoint(Position position) => Point(latitude: position.latitude, longitude: position.longitude);
}
