import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/custom_checkbox.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: ShapeDecoration(
            color: colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'sort'.tr(),
                  textAlign: TextAlign.center,
                  style: fonts.subtitle2.copyWith(fontSize: 18.sp),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: icons.clear.svg(
                    color: colors.text,
                    height: 30.w,
                  ),
                ),
              ]),
              10.verticalSpace,
              for (int index = 0; index < sortType.length; index++)
                _buildListTile(
                    title: sortType.values.toList()[index].tr(),
                    selected: state.orderBy == sortType.keys.toList()[index],
                    onTap: () {
                      context.read<SearchBloc>().add(SearchEvent.setSort(
                          type: sortType.keys.toList()[index]));
                      Navigator.pop(context);
                    },
                    fonts: fonts),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        );
      });
    });
  }

  Widget _buildListTile({
    required String title,
    required bool selected,
    required VoidCallback onTap,
    required FontSet fonts,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      horizontalTitleGap: 10.w,
      onTap: onTap,
      leading: CustomCheckBoxComponent(
        horizontalMargin: 0,
        isCheck: selected == true ? true : false,
        onChanged: () {},
      ),
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: fonts.subtitle1,
      ),
    );
  }
}
