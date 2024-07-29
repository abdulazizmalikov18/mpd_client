import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/application/yandex/search_by_specialist/search_by_specialist_bloc.dart';
import 'package:mpd_client/application/yandex/yandex_doctor/yandex_doctor_bloc.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/grandient_icon.dart';
import 'package:mpd_client/presentation/widgets/loading_platform.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';


class AutoComplete extends StatelessWidget {
  final SearchBySpecialistState state;
  final BuildContext oldcontext;
  const AutoComplete({super.key, required this.state, required this.oldcontext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        elevation: 20,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: _buildSpecialists(context),
        ),
      ),
    );
  }

  Widget _buildSpecialists(BuildContext context) {
    if (state is SearchBySpecialistLoading) {
      return const Center(child: LoadingPlatform());
    } else if (state is SearchBySpecialistSuccess) {
      if (state.searchedSpecialists.isEmpty) {
        return const SizedBox();
        // return _buildResultInfo(context.l10n.search_doctor_no_result, context);
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.searchedSpecialists.length,
        itemBuilder: (_, index) {
          final specialist = state.searchedSpecialists[index];
          return ListTile(
            onTap: () {
              FocusScope.of(context).unfocus();
              context.read<SearchBySpecialistBloc>().add(CloseSuggessionsEvent());

              context.read<YandexDoctorBloc>().add(InsertSingleObjectEvent(specialist: specialist, context: oldcontext));
            },
            splashColor: background,
            minLeadingWidth: 0,
            leading: const GradientIcon(iconName: AppIcons.location, size: 24),
            title: Text('${specialist.name} ${specialist.lastname}'),
          );
        },
      );
    } else {
      if ((state as SearchBySpecialistFailure).failure != 'Internet connection failure') {
        return _buildResultInfo(context.l10n.appointment_server_error, context);
      }
      return _buildResultInfo(context.l10n.error_connection_lost_title, context);
    }
  }

  Widget _buildResultInfo(String info, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10),
      child: Text(
        info,
        style: AppTheme.headlineSmall.copyWith(
          color: grey,
        ),
      ),
    );
  }
}
