import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/profile/profile_bloc.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class EditAppBarComp extends StatelessWidget {
  const EditAppBarComp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        leading: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            tooltip: 'back'.tr(),
            onPressed: () => Navigator.pop(context),
            icon: icons.back.svg(height: 16),
          ),
        ),
        toolbarHeight: 120.h,
        surfaceTintColor: Colors.white,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimationButtonEffect(
                onTap: () {
                  context
                      .read<ProfileBloc>()
                      .add(ProfileEvent.pickImage(context));
                },
                child: Stack(
                  children: [
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return state.pickedImagePath != null
                            ? CircleAvatar(
                                radius: 42.r,
                                backgroundImage:
                                    FileImage(File(state.pickedImagePath!)),
                              )
                            : state.profileParam?.profilePic != null
                                ? CircleAvatar(
                                    radius: 42.r,
                                    backgroundColor: colors.grey1,
                                    backgroundImage: CachedNetworkImageProvider(
                                        state.profileParam!.profilePic!),
                                  )
                                : CircleAvatar(
                                    radius: 42.r,
                                    backgroundColor: colors.grey1,
                                    backgroundImage: AssetImage(icons.user),
                                  );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                              color: colors.text, shape: BoxShape.circle),
                          child: icons.plus
                              .svg(color: colors.white, height: 16.r)),
                    )
                  ],
                ),
              ),
              8.verticalSpace,
            ],
          ),
        ),
      );
    });
  }

  // Future<Widget> _buildAvatar() async {
  //   List<AssetEntity>? imagePaths = await ImageService.showPicker(event.context,
  //       cropStyle: CropStyle.rectangle, maxAssets: 1, selectedAssets: [], aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
  //   if (imagePaths != null && imagePaths.isNotEmpty) {
  //     Map<String, dynamic> map = Map.from(state.pickedImagePath);
  //     File? file = await imagePaths.first.originFile;
  //     if (file != null) {
  //       if (event.type != imageTypes.last) {
  //         map[event.type] = file.path;
  //       }
  //     }
  //   }
  // }
}
