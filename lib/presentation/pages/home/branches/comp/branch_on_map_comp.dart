import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BrancheOnMapComp extends StatelessWidget {
  final BranchModel param;
  const BrancheOnMapComp({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'branch_on_the_map'.tr(),
            style: Style.medium14(size: 15.sp),
          ),
          16.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 198,
              width: double.maxFinite,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(param.lat ?? 0, param.long ?? 0),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'www.google.com',
                  ),
                  MarkerLayer(markers: [
                    Marker(
                        point: LatLng(param.lat ?? 0, param.long ?? 0),
                        child: icons.location.svg())
                  ])
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }
}
