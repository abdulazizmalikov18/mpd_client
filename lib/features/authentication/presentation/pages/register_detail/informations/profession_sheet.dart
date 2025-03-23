import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/domain/blocs/bloc/profession_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/widgets/bottom_sheet_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/search_field_widget.dart';

import 'components/profession_category.dart';

class ProfessionSheet extends StatefulWidget {
  const ProfessionSheet({
    super.key,
  });

  @override
  State<ProfessionSheet> createState() => _ProfessionSheetState();
}

class _ProfessionSheetState extends State<ProfessionSheet>
    with AutomaticKeepAliveClientMixin {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BottomSheetWidget(children: [
      ScreenUtil().setVerticalSpacing(32.h),
      Center(
        child: Text(
          context.l10n.register_profession_title,
          textAlign: TextAlign.center,
          style: Styles.boldTitle.copyWith(
              color: context.color.black,
              fontSize: 24.sp,
              fontFamily: Styles.gilroyMedium),
        ),
      ),
      ScreenUtil().setVerticalSpacing(24.h),
      Row(
        children: [
          ScreenUtil().setHorizontalSpacing(16),
          Flexible(
            child: Focus(
              onFocusChange: (value) {
                setState(() {
                  hasFocus = value;
                });
              },
              child: SearchFieldWidget(
                hasFocus: hasFocus,
                controller: context.read<ProfessionBloc>().searchController,
                searchHint: context.l10n.register_profession_search,
                onChanged: (query) {
                  context
                      .read<ProfessionBloc>()
                      .add(SearchProfessionsEvent(query));
                },
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            child: hasFocus
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: InkWell(
                      onTap: () {
                        hasFocus = false;
                        FocusScope.of(context).unfocus();
                        // context
                        //     .read<ProfessionsBloc>()
                        //     .add(GetProffesionsEvent());
                      },
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
                        child: Text(
                          context.l10n.register_profession_search_cancel,
                          style: Styles.descSubtitle
                              .copyWith(color: context.color.grey),
                        ),
                      ),
                    ))
                : ScreenUtil().setHorizontalSpacing(16.w),
          )
        ],
      ),
      Expanded(
        child: BlocBuilder<ProfessionBloc, ProfessionState>(
          builder: (context, state) {
            if (state is ProfessionFailure) {
              return Center(child: Text(state.failure));
            } else if (state is ProfessionSuccess) {
              if (state.professions.isEmpty) {
                return const Center(child: Text('Empty Professions'));
              }
              return ProfessionCategory(
                scrollController: ScrollController(),
                professions: state.professions,
                isEnd: state.hasReachedMax,
                onScrollEndBloc: () {
                  context.read<ProfessionBloc>().add(GetProfessionEvent());
                  // state.isSearch
                  //     ? bloc.add(GetProfesionsFromSearch(query: state.oldQuery))
                  //     : bloc.add(GetProffesionsEvent());
                },
              );
            }
            return const Center(child: LoadingPlatform());
          },
        ),
      )
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}

/*
  hasFocus = false;
                        FocusScope.of(context).unfocus();
                        context
                            .read<ProfessionsBloc>()
                            .add(GetProffesionsEvent());


 */
