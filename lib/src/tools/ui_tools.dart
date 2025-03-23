import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

abstract class UiTools {
  static SnackBar noInternetSnackbar(String title) {
    final snackBar = SnackBar(
      content: Text(title),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 10000),
      margin: const EdgeInsets.all(50),
      elevation: 30,
    );
    return snackBar;
  }

  static Container toast(
      {required String title, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: context.color.red),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              Utils.errorFormat(title),
              overflow: TextOverflow.ellipsis,
              style: Styles.boldHeadline6.copyWith(color: context.color.red),
            ),
          ),
        ],
      ),
    );
  }

  static SnackBar failurefailureSnackBar(
          {required String title, required String message}) =>
      SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 20,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

  static SnackBar failSnackbar(
          {required String title, required BuildContext context}) =>
      SnackBar(
          content: Row(
            children: [
              SvgPicture.asset(
                AppIcons.circleCancel,
                height: 20.h,
                width: 20.h,
                colorFilter: ColorFilter.mode(
                    context.color.gradientRedOpacity, BlendMode.srcIn),
              ),
              ScreenUtil().setHorizontalSpacing(8),
              Expanded(
                child: Text(
                  title,
                  style: Styles.descSubtitle
                      .copyWith(color: context.color.gradientRedOpacity),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          backgroundColor: context.color.white);

  static Future<void> openMapsSheet(
    BuildContext context,
    String job,
    Coords coords,
  ) async {
    MapLauncher.installedMaps.then(
      (availableMaps) {
        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Material(
                  color: context.color.white,
                  borderRadius: BorderRadius.circular(18.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenUtil().setVerticalSpacing(18.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          context.l10n.select_the_map,
                          style: Styles.headline4.copyWith(
                            color: context.color.black,
                          ),
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(20.h),
                      SizedBox(
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: availableMaps.length,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemBuilder: (context, index) {
                            final map = availableMaps[index];
                            return Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: InkWell(
                                onTap: () =>
                                    map.showMarker(coords: coords, title: job),
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ScreenUtil().setVerticalSpacing(6.h),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: SvgPicture.asset(map.icon,
                                          height: 50),
                                    ),
                                    ScreenUtil().setVerticalSpacing(6.h),
                                    Text(map.mapName)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(20.h),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
      onError: (error) => debugPrint(error.toString()),
    );
  }
}
