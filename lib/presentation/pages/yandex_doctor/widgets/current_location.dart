import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/yandex/yandex_doctor/yandex_doctor_bloc.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/widgets/icon_button_circle.dart';

class CurrentLocation extends StatelessWidget {
  final bool showDoctorInfo;
  const CurrentLocation({super.key, required this.showDoctorInfo});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      right: 6.w,
      bottom: showDoctorInfo ? 192.h : 72.h,
      child: IconCircleButton(
        onPressed: () {
          context.read<YandexDoctorBloc>().add(GetCurrentLocationEvent());
        },
        icon: AppIcons.myLocation,
      ),
    );
  }
}
