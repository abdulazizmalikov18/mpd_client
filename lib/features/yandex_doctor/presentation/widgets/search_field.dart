import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/extension/context_ext.dart';
import 'package:mpd_client/core/locator.dart';
import 'package:mpd_client/features/home/data/repositories/home_repository.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/domain/blocs/specialist/specialist_bloc.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/doctor_category_page.dart';
import 'package:mpd_client/features/yandex_doctor/presentation/widgets/filter_category_sheet.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/widgets/search_field_widget.dart';

import '../../domain/blocs/search_by_specialist/search_by_specialist_bloc.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final bool isMap;
  final Function(String)? onChanged;
  const SearchField({
    super.key,
    required this.controller,
    this.isMap = true,
    this.onChanged,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: context.color.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Focus(
              onFocusChange: (focus) {
                if (focus) {
                  context
                      .read<SearchBySpecialistBloc>()
                      .add(FocusedSearchingEvent());
                }
              },
              child: SearchFieldWidget(
                controller: widget.controller,
                searchHint: context.l10n.search_doctor,
                onChanged: (query) {
                  if (widget.onChanged != null) {
                    widget.onChanged!(query);
                  }
                },
              ),
            ),
          ),
          if (widget.isMap)
            Row(
              children: [
                ScreenUtil().setHorizontalSpacing(8.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Material(
                    color: context.color.background,
                    child: InkWell(
                      onTap: () {
                        final bloc = context.read<SpecialistBloc>();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: bloc,
                              ),
                              BlocProvider(
                                create: (context) => ProductSpecalistBloc(
                                  locator.get<HomeRepository>(),
                                ),
                              ),
                            ],
                            child: DoctorCategoryPage(
                              controller: widget.controller,
                            ),
                          ),
                        ));
                      },
                      child: Container(
                        height: 48.h,
                        width: 48.h,
                        color: context.color.mainBlue,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppIcons.map,
                          colorFilter: ColorFilter.mode(
                            context.color.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ScreenUtil().setHorizontalSpacing(8.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Material(
              color: context.color.background,
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
                          value: BlocProvider.of<SpecialistBloc>(context,
                              listen: false),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<SpecialistBloc>(context,
                              listen: false),
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
                    colorFilter:
                        ColorFilter.mode(context.color.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
