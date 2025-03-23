import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/district/district_bloc.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/themes/styles.dart';

class DistrictCategory extends StatelessWidget {
  final ScrollController _scrollController;
  final List<Region> _districts;
  final VoidCallback onScrollEndBloc;
  final bool isEmpty;
  const DistrictCategory(
      {super.key,
      required ScrollController scrollController,
      required List<Region> districts,
      required this.isEmpty,
      required this.onScrollEndBloc})
      : _scrollController = scrollController,
        _districts = districts;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _districts.length,
        shrinkWrap: true,
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index >= _districts.length) {
            if (isEmpty) {
              return const SizedBox();
            }
            return Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: const LoadingPlatform(),
            ));
          }
          return Material(
            color: context.color.white,
            child: Theme(
              data: ThemeData(
                  highlightColor:
                      context.color.mainBlue.withValues(alpha: 0.1)),
              child: ListTile(
                  onTap: () {
                    context.read<DistrictBloc>().add(SelectDistrictEvent(
                        selectedDistrict: _districts[index]));
                    Navigator.pop(context);
                  },
                  contentPadding: EdgeInsets.only(left: 32.w),
                  title: Text(
                    _districts[index].name,
                    style: Styles.descSubtitle
                        .copyWith(color: context.color.black),
                  )),
            ),
          );
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      onScrollEndBloc();
    }
    return false;
  }
}
