import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mpd_client/utils/appointment_tools.dart';
import 'package:mpd_client/utils/utils.dart';

class MapLauncher {
  static const MethodChannel _channel = MethodChannel('map_launcher');

  /// Returns list of installed map apps on the device.
  static Future<List<AvailableMap>> get installedMaps async {
    final maps = await _channel.invokeMethod('getInstalledMaps');
    return List<AvailableMap>.from(
      maps.map((map) => AvailableMap.fromJson(map)),
    );
  }

  /// Opens map app specified in [mapType]
  /// and shows marker at [coords]
  static Future<dynamic> showMarker({
    required MapType mapType,
    required Coords coords,
    required String title,
    String? description,
    int? zoom,
    Map<String, String>? extraParams,
  }) async {
    final String url = getMapMarkerUrl(
      mapType: mapType,
      coords: coords,
      title: title,
      description: description,
      zoom: zoom,
      extraParams: extraParams,
    );

    final Map<String, String?> args = {
      'mapType': Utils.enumToString(mapType),
      'url': Uri.encodeFull(url),
      'title': title,
      'description': description,
      'latitude': coords.latitude.toString(),
      'longitude': coords.longitude.toString(),
    };
    return _channel.invokeMethod('showMarker', args);
  }

  /// Opens map app specified in [mapType]
  /// and shows directions to [destination]
  static Future<dynamic> showDirections({
    required MapType mapType,
    required Coords destination,
    String? destinationTitle,
    Coords? origin,
    String? originTitle,
    List<Waypoint>? waypoints,
    DirectionsMode? directionsMode = DirectionsMode.driving,
    Map<String, String>? extraParams,
  }) async {
    final url = getMapDirectionsUrl(
      mapType: mapType,
      destination: destination,
      destinationTitle: destinationTitle,
      origin: origin,
      originTitle: originTitle,
      waypoints: waypoints,
      directionsMode: directionsMode,
      extraParams: extraParams,
    );

    final Map<String, dynamic> args = {
      'mapType': Utils.enumToString(mapType),
      'url': Uri.encodeFull(url),
      'destinationTitle': destinationTitle,
      'destinationLatitude': destination.latitude.toString(),
      'destinationLongitude': destination.longitude.toString(),
      'destinationtitle': destinationTitle,
      'originLatitude': origin?.latitude.toString(),
      'originLongitude': origin?.longitude.toString(),
      'originTitle': originTitle,
      'directionsMode': Utils.enumToString(directionsMode),
      'waypoints': (waypoints ?? [])
          .map((waypoint) => {
                'latitude': waypoint.latitude.toString(),
                'longitude': waypoint.longitude.toString(),
                'title': waypoint.title,
              })
          .toList(),
    };
    return _channel.invokeMethod('showDirections', args);
  }

  /// Returns boolean indicating if map app is installed
  static Future<bool?> isMapAvailable(MapType mapType) async {
    return _channel.invokeMethod(
      'isMapAvailable',
      {'mapType': Utils.enumToString(mapType)},
    );
  }
}




/// Returns a url that is used by [showMarker]
String getMapMarkerUrl({
  required MapType mapType,
  required Coords coords,
  String? title,
  String? description,
  int? zoom,
  Map<String, String>? extraParams,
}) {
  final zoomLevel = zoom ?? 16;
  switch (mapType) {
    case MapType.google:
      return Utils.buildUrl(
        url: Platform.isIOS ? 'comgooglemaps://' : 'geo:0,0',
        queryParams: {
          'q':
              '${coords.latitude},${coords.longitude}${title != null && title.isNotEmpty ? '($title)' : ''}',
          'zoom': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.googleGo:
      return Utils.buildUrl(
        url: 'http://maps.google.com/maps',
        queryParams: {
          'q':
              '${coords.latitude},${coords.longitude}${title != null && title.isNotEmpty ? '($title)' : ''}',
          'zoom': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.amap:
      return Utils.buildUrl(
        url: '${Platform.isIOS ? 'ios' : 'android'}amap://viewMap',
        queryParams: {
          'sourceApplication': 'map_launcher',
          'poiname': '$title',
          'lat': '${coords.latitude}',
          'lon': '${coords.longitude}',
          'zoom': '$zoomLevel',
          'dev': '0',
          ...(extraParams ?? {}),
        },
      );

    case MapType.baidu:
      return Utils.buildUrl(
        url: 'baidumap://map/marker',
        queryParams: {
          'location': '${coords.latitude},${coords.longitude}',
          'title': title ?? 'Title',
          'content': description ??
              'Description', // baidu fails if no description provided
          'traffic': 'on',
          'src': 'com.map_launcher',
          'coord_type': 'gcj02',
          'zoom': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.apple:
      return Utils.buildUrl(
        url: 'http://maps.apple.com/maps',
        queryParams: {
          'saddr': '${coords.latitude},${coords.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.waze:
      return Utils.buildUrl(
        url: 'waze://',
        queryParams: {
          'll': '${coords.latitude},${coords.longitude}',
          'z': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.yandexNavi:
      return Utils.buildUrl(
        url: 'yandexnavi://show_point_on_map',
        queryParams: {
          'lat': '${coords.latitude}',
          'lon': '${coords.longitude}',
          'zoom': '$zoomLevel',
          'no-balloon': '0',
          'desc': '$title',
          ...(extraParams ?? {}),
        },
      );

    case MapType.yandexMaps:
      return Utils.buildUrl(
        url: 'yandexmaps://maps.yandex.ru/',
        queryParams: {
          'pt': '${coords.longitude},${coords.latitude}',
          'z': '$zoomLevel',
          'l': 'map',
          ...(extraParams ?? {}),
        },
      );

    case MapType.citymapper:
      return Utils.buildUrl(
        url: 'citymapper://directions',
        queryParams: {
          'endcoord': '${coords.latitude},${coords.longitude}',
          'endname': '$title',
          ...(extraParams ?? {}),
        },
      );

    case MapType.mapswithme:
      return Utils.buildUrl(
        url: 'mapsme://map',
        queryParams: {
          'v': '1',
          'll': '${coords.latitude},${coords.longitude}',
          'n': title,
          ...(extraParams ?? {}),
        },
      );

    case MapType.osmand:
    case MapType.osmandplus:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'osmandmaps://',
          queryParams: {
            'lat': '${coords.latitude}',
            'lon': '${coords.longitude}',
            'z': '$zoomLevel',
            'title': title,
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'http://osmand.net/go',
        queryParams: {
          'lat': '${coords.latitude}',
          'lon': '${coords.longitude}',
          'z': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.doubleGis:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'dgis://2gis.ru/geo/${coords.longitude},${coords.latitude}',
          queryParams: {
            ...(extraParams ?? {}),
          },
        );
      }

      // android app does not seem to support marker by coordinates
      // so falling back to directions
      return Utils.buildUrl(
        url:
            'dgis://2gis.ru/routeSearch/rsType/car/to/${coords.longitude},${coords.latitude}',
        queryParams: {
          ...(extraParams ?? {}),
        },
      );

    case MapType.tencent:
      return Utils.buildUrl(
        url: 'qqmap://map/marker',
        queryParams: {
          'marker':
              'coord:${coords.latitude},${coords.longitude}${title != null ? ';title:$title' : ''}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.here:
      return Utils.buildUrl(
        url:
            'https://share.here.com/l/${coords.latitude},${coords.longitude},$title',
        queryParams: {
          'z': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.petal:
      return Utils.buildUrl(
        url: 'petalmaps://poidetail',
        queryParams: {
          'marker': '${coords.latitude},${coords.longitude}',
          'z': '$zoomLevel',
          ...(extraParams ?? {}),
        },
      );

    case MapType.tomtomgo:
      if (Platform.isIOS) {
        // currently uses the navigate endpoint on iOS, even when just showing a marker
        return Utils.buildUrl(
          url: 'tomtomgo://x-callback-url/navigate',
          queryParams: {
            'destination': '${coords.latitude},${coords.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'geo:${coords.latitude},${coords.longitude}',
        queryParams: {
          'q':
              '${coords.latitude},${coords.longitude}${title != null && title.isNotEmpty ? '($title)' : ''}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.copilot:
      // Documentation:
      // https://developer.trimblemaps.com/copilot-navigation/v10-19/feature-guide/advanced-features/url-launch/
      return Utils.buildUrl(
        url: 'copilot://mydestination',
        queryParams: {
          'type': 'LOCATION',
          'action': 'VIEW',
          'marker': '${coords.latitude},${coords.longitude}',
          'name': title ?? '',
          ...(extraParams ?? {}),
        },
      );

    case MapType.tomtomgofleet:
      return Utils.buildUrl(
        url: 'geo:${coords.latitude},${coords.longitude}',
        queryParams: {
          'q':
              '${coords.latitude},${coords.longitude}${title != null && title.isNotEmpty ? '($title)' : ''}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.sygicTruck:
      // Documentation:
      // https://www.sygic.com/developers/professional-navigation-sdk/introduction
      return Utils.buildUrl(
        url:
            'com.sygic.aura://coordinate|${coords.longitude}|${coords.latitude}|show',
        queryParams: {
          ...(extraParams ?? {}),
        },
      );

    case MapType.flitsmeister:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'flitsmeister://',
          queryParams: {
            'geo': '${coords.latitude},${coords.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'geo:${coords.latitude},${coords.longitude}',
        queryParams: {
          'q': '${coords.latitude},${coords.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.truckmeister:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'truckmeister://',
          queryParams: {
            'geo': '${coords.latitude},${coords.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'geo:${coords.latitude},${coords.longitude}',
        queryParams: {
          'q': '${coords.latitude},${coords.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.naver:
      return Utils.buildUrl(
        url: 'nmap://place',
        queryParams: {
          'lat': '${coords.latitude}',
          'lng': '${coords.longitude}',
          'zoom': '$zoomLevel',
          'name': title,
          ...(extraParams ?? {}),
        },
      );

    case MapType.kakao:
      return Utils.buildUrl(
        url: 'kakaomap://look',
        queryParams: {
          'p': '${coords.latitude},${coords.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.tmap:
      return Utils.buildUrl(
        url: 'tmap://viewmap',
        queryParams: {
          'name': '$title',
          'x': '${coords.longitude}',
          'y': '${coords.latitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.mapyCz:
      return Utils.buildUrl(
        url: 'https://mapy.cz/zakladni',
        queryParams: {
          'id': '${coords.longitude},${coords.latitude}',
          'z': '$zoomLevel',
          'source': 'coor',
        },
      );
  }
}




/// Returns a url that is used by [showDirections]
String getMapDirectionsUrl({
  required MapType mapType,
  required Coords destination,
  String? destinationTitle,
  Coords? origin,
  String? originTitle,
  DirectionsMode? directionsMode,
  List<Waypoint>? waypoints,
  Map<String, String>? extraParams,
}) {
  switch (mapType) {
    case MapType.google:
      return Utils.buildUrl(
        url: 'https://www.google.com/maps/dir/',
        queryParams: {
          'api': '1',
          'destination': '${destination.latitude},${destination.longitude}',
          'origin': Utils.nullOrValue(
            origin,
            '${origin?.latitude},${origin?.longitude}',
          ),
          'waypoints': waypoints
              ?.map((waypoint) => '${waypoint.latitude},${waypoint.longitude}')
              .join('|'),
          'travelmode': Utils.enumToString(directionsMode),
          ...(extraParams ?? {}),
        },
      );

    case MapType.googleGo:
      return Utils.buildUrl(
        url: 'https://www.google.com/maps/dir/',
        queryParams: {
          'api': '1',
          'destination': '${destination.latitude},${destination.longitude}',
          'origin': Utils.nullOrValue(
            origin,
            '${origin?.latitude},${origin?.longitude}',
          ),
          'waypoints': waypoints
              ?.map((waypoint) => '${waypoint.latitude},${waypoint.longitude}')
              .join('|'),
          'travelmode': Utils.enumToString(directionsMode),
          ...(extraParams ?? {}),
        },
      );

    case MapType.apple:
      return Utils.buildUrl(
        url: 'http://maps.apple.com/maps',
        queryParams: {
          'daddr': '${destination.latitude},${destination.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.amap:
      return Utils.buildUrl(
        url: Platform.isIOS ? 'iosamap://path' : 'amapuri://route/plan/',
        queryParams: {
          'sourceApplication': 'applicationName',
          'dlat': '${destination.latitude}',
          'dlon': '${destination.longitude}',
          'dname': destinationTitle,
          'slat': Utils.nullOrValue(origin, '${origin?.latitude}'),
          'slon': Utils.nullOrValue(origin, '${origin?.longitude}'),
          'sname': originTitle,
          't': Utils.getAmapDirectionsMode(directionsMode),
          'dev': '0',
          ...(extraParams ?? {}),
        },
      );

    case MapType.baidu:
      return Utils.buildUrl(
        url: 'baidumap://map/direction',
        queryParams: {
          'destination':
              'name: ${destinationTitle ?? 'Destination'}|latlng:${destination.latitude},${destination.longitude}',
          'origin': Utils.nullOrValue(
            origin,
            'name: ${originTitle ?? 'Origin'}|latlng:${origin?.latitude},${origin?.longitude}',
          ),
          'coord_type': 'gcj02',
          'mode': Utils.getBaiduDirectionsMode(directionsMode),
          'src': 'com.map_launcher',
          ...(extraParams ?? {}),
        },
      );

    case MapType.waze:
      return Utils.buildUrl(
        url: 'waze://',
        queryParams: {
          'll': '${destination.latitude},${destination.longitude}',
          'z': '10',
          'navigate': 'yes',
          ...(extraParams ?? {}),
        },
      );

    case MapType.citymapper:
      return Utils.buildUrl(url: 'citymapper://directions', queryParams: {
        'endcoord': '${destination.latitude},${destination.longitude}',
        'endname': destinationTitle,
        'startcoord': Utils.nullOrValue(
          origin,
          '${origin?.latitude},${origin?.longitude}',
        ),
        'startname': originTitle,
        ...(extraParams ?? {}),
      });

    case MapType.osmand:
    case MapType.osmandplus:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'osmandmaps://navigate',
          queryParams: {
            'lat': '${destination.latitude}',
            'lon': '${destination.longitude}',
            'title': destinationTitle,
            ...(extraParams ?? {}),
          },
        );
      }
      return 'osmand.navigation:q=${destination.latitude},${destination.longitude}';

    case MapType.mapswithme:
      // Couldn't get //route to work properly as of 2020/07
      // so just using the marker method for now
      // return Utils.buildUrl(
      //   url: 'mapsme://route',
      //   queryParams: {
      //     'dll': '${destination.latitude},${destination.longitude}',
      //     'daddr': destinationTitle,
      //     'sll': Utils.nullOrValue(
      //       origin,
      //       '${origin?.latitude},${origin?.longitude}',
      //     ),
      //     'saddr': originTitle,
      //     'type': Utils.getMapsMeDirectionsMode(directionsMode),
      //   },
      // );
      return Utils.buildUrl(
        url: 'mapsme://map',
        queryParams: {
          'v': '1',
          'll': '${destination.latitude},${destination.longitude}',
          'n': destinationTitle,
          ...(extraParams ?? {}),
        },
      );

    case MapType.yandexMaps:
      return Utils.buildUrl(
        url: 'yandexmaps://maps.yandex.com/',
        queryParams: {
          'rtext':
              '${origin?.latitude},${origin?.longitude}~${destination.latitude},${destination.longitude}',
          'rtt': Utils.getYandexMapsDirectionsMode(directionsMode),
          ...(extraParams ?? {}),
        },
      );

    case MapType.yandexNavi:
      return Utils.buildUrl(
        url: 'yandexnavi://build_route_on_map',
        queryParams: {
          'lat_to': '${destination.latitude}',
          'lon_to': '${destination.longitude}',
          'lat_from': Utils.nullOrValue(origin, '${origin?.latitude}'),
          'lon_from': Utils.nullOrValue(origin, '${origin?.longitude}'),
        },
      );

    case MapType.doubleGis:
      return Utils.buildUrl(
        url:
            'dgis://2gis.ru/routeSearch/rsType/${Utils.getDoubleGisDirectionsMode(directionsMode)}/${origin == null ? '' : 'from/${origin.longitude},${origin.latitude}/'}to/${destination.longitude},${destination.latitude}',
        queryParams: {
          ...(extraParams ?? {}),
        },
      );

    case MapType.tencent:
      return Utils.buildUrl(
        url: 'qqmap://map/routeplan',
        queryParams: {
          'from': originTitle,
          'fromcoord': '${origin?.latitude},${origin?.longitude}',
          'to': destinationTitle,
          'tocoord': '${destination.latitude},${destination.longitude}',
          'type': Utils.getTencentDirectionsMode(directionsMode),
          ...(extraParams ?? {}),
        },
      );

    case MapType.here:
      return Utils.buildUrl(
        url:
            'https://share.here.com/r/${origin?.latitude},${origin?.longitude},$originTitle/${destination.latitude},${destination.longitude}',
        queryParams: {
          'm': Utils.getHereDirectionsMode(directionsMode),
          ...(extraParams ?? {}),
        },
      );

    case MapType.petal:
      return Utils.buildUrl(url: 'petalmaps://route', queryParams: {
        'daddr':
            '${destination.latitude},${destination.longitude} (${destinationTitle ?? 'Destination'})',
        'saddr': Utils.nullOrValue(
          origin,
          '${origin?.latitude},${origin?.longitude} (${originTitle ?? 'Origin'})',
        ),
        'type': Utils.getTencentDirectionsMode(directionsMode),
        ...(extraParams ?? {}),
      });

    case MapType.tomtomgo:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'tomtomgo://x-callback-url/navigate',
          queryParams: {
            'destination': '${destination.latitude},${destination.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'google.navigation:',
        queryParams: {
          'q': '${destination.latitude},${destination.longitude}',
          ...(extraParams ?? {}),
        },
        // the TomTom Go app cannot handle the ? at the start of the query
      ).replaceFirst('?', '');

    case MapType.copilot:
      // Documentation:
      // https://developer.trimblemaps.com/copilot-navigation/v10-19/feature-guide/advanced-features/url-launch/
      return Utils.buildUrl(
        url: 'copilot://mydestination',
        queryParams: {
          'type': 'LOCATION',
          'action': 'GOTO',
          'name': destinationTitle ?? '',
          'lat': "${destination.latitude}",
          'long': "${destination.longitude}",
          ...(extraParams ?? {}),
        },
      );

    case MapType.tomtomgofleet:
      return Utils.buildUrl(
        url: 'google.navigation:',
        queryParams: {
          'q': '${destination.latitude},${destination.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.sygicTruck:
      // Documentation:
      // https://www.sygic.com/developers/professional-navigation-sdk/introduction
      return Utils.buildUrl(
        url:
            'com.sygic.aura://coordinate|${destination.longitude}|${destination.latitude}|drive',
        queryParams: {
          ...(extraParams ?? {}),
        },
      );

    case MapType.flitsmeister:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'flitsmeister://',
          queryParams: {
            'geo': '${destination.latitude},${destination.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'geo:${destination.latitude},${destination.longitude}',
        queryParams: {},
      );

    case MapType.truckmeister:
      if (Platform.isIOS) {
        return Utils.buildUrl(
          url: 'truckmeister://',
          queryParams: {
            'geo': '${destination.latitude},${destination.longitude}',
            ...(extraParams ?? {}),
          },
        );
      }
      return Utils.buildUrl(
        url: 'geo:${destination.latitude},${destination.longitude}',
        queryParams: {
          'q': '${destination.latitude},${destination.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.naver:
      return Utils.buildUrl(
        url: 'nmap://route/car',
        queryParams: {
          'slat': origin?.latitude.toString(),
          'slng': origin?.longitude.toString(),
          'sname': originTitle,
          'dlat': '${destination.latitude}',
          'dlng': '${destination.longitude}',
          'dname': destinationTitle,
          ...(extraParams ?? {}),
        },
      );

    case MapType.kakao:
      return Utils.buildUrl(
        url: 'kakaomap://route',
        queryParams: {
          'sp':
              origin == null ? null : '${origin.latitude},${origin.longitude}',
          'ep': '${destination.latitude},${destination.longitude}',
          ...(extraParams ?? {}),
        },
      );

    case MapType.tmap:
      return Utils.buildUrl(
        url: 'tmap://route',
        queryParams: {
          'startname': originTitle,
          'startx': origin?.longitude.toString(),
          'starty': origin?.latitude.toString(),
          'goalname': destinationTitle,
          'goaly': '${destination.latitude}',
          'goalx': '${destination.longitude}',
          'carType': '1',
          ...(extraParams ?? {}),
        },
      );

    case MapType.mapyCz:
      return Utils.buildUrl(
        url: 'https://mapy.cz/zakladni',
        queryParams: {
          'id': '${destination.longitude},${destination.latitude}',
          'source': 'coor',
        },
      );
  }
}
