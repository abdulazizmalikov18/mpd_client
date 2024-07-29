import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/application/yandex/filter_category/filter_category_bloc.dart';
import 'package:mpd_client/application/yandex/search_by_category/search_by_category_bloc.dart';
import 'package:mpd_client/presentation/pages/yandex_doctor/widgets/filter_category_sheet.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_search_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import '../../../../application/yandex/search_by_specialist/search_by_specialist_bloc.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  const SearchField({super.key, required this.controller});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (focus) {
                  if (focus) {
                    context.read<SearchBySpecialistBloc>().add(FocusedSearchingEvent());
                  }
                },
                child: SearchFieldWidget(
                  controller: widget.controller,
                  searchHint: context.l10n.search_doctor,
                  onChanged: (query) {
                    if (query.isEmpty || query.length < 3) {
                      context.read<SearchBySpecialistBloc>().add(StopSearchingEvent());
                      setState(() {});
                    }
                    context.read<SearchBySpecialistBloc>().add(SearchedSpecialistEvent(query));
                  },
                ),
              ),
            ),
            ScreenUtil().setHorizontalSpacing(8.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Material(
                color: background,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: BlocProvider.of<FilterCategoryBloc>(context, listen: false),
                          ),
                          BlocProvider.value(
                            value: BlocProvider.of<SearchByCategoryBloc>(context, listen: false),
                          )
                        ],
                        child: const FilterCategorySheet(),
                      ),
                    );
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppIcons.filter,
                      colorFilter: ColorFilter.mode(black, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
