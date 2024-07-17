import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_textformfield_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';

class SelectRegionPage extends StatelessWidget {
  const SelectRegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (context, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.backgroundScaffold,
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: AppBarComponent(
                title: "select_region".tr(),
                // color: colors.backgroundScaffold,
              ),
            )
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: Column(
                children: [
                  CustomTextFieldComp(
                    label: "find_region".tr(),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          Navigator.pop(context, listProvince[index]);
                        },
                        title:
                            Text(listProvince[index], style: fonts.headline1),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return Divider(color: colors.customGreyC3);
                    },
                    itemCount: listProvince.length,
                  ),
                  SafeArea(
                    top: false,
                    child: 40.verticalSpace,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
