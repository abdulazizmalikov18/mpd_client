import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/domain/blocs/region/region_bloc.dart';
import 'package:mpd_client/features/authentication/domain/inherited/open_close_notifier.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/region_category.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';

class RegionSheet extends StatelessWidget {
  const RegionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(children: [
      ScreenUtil().setVerticalSpacing(32.h),
      Center(
        child: Text(
          context.l10n.register_region_title,
          textAlign: TextAlign.center,
          style: Styles.boldTitle.copyWith(color: context.color.black, fontSize: 24.sp, fontFamily: Styles.gilroyMedium),
        ),
      ),
      ScreenUtil().setVerticalSpacing(6.h),
      Expanded(
        child: BlocBuilder<RegionBloc, RegionState>(
          builder: (context, state) {
            if (state.regions.isEmpty && state is RegionSuccess) {
              return const Text('Regions are empty');
            }
            if (state is RegionLoading) {
              return const Center(child: LoadingPlatform());
            }
            return OpenCloseExpansionInheritedNotifier(
              openCloseNotifier: OpenCloseNotifier(),
              child: RegionCategory(regions: state.regions),
            );
          },
        ),
      )
    ]);
  }
}
