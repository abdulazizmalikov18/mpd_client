import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/main/main_bloc.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/repositories/main_repo.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/home/branches/comp/branch_dialog_comp.dart';
import 'package:orient_motors/presentation/pages/home/branches/comp/branch_on_map_comp.dart';
import 'package:orient_motors/presentation/pages/home/branches/comp/info_about_branch_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/gallery_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class BranchDetailPage extends StatelessWidget {
  final BranchModel param;
  const BranchDetailPage({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (_, colors, fonts, icons, controller) {
      return Scaffold(
        backgroundColor: colors.white,
        appBar: AppBarComponent(
          title: param.name ?? "",
          color: colors.white,
          isBorder: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Gallery2Comp(images: param.photos?.toList() ?? []),
              InfoAboutBranchComp(param: param),
              BrancheOnMapComp(param: param),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  backgroundColor: colors.white,
                  verticalPadding: 13.h,
                  titleColor: colors.text,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return BlocProvider(
                          create: (context) => MainBloc(MainRepository(
                              context.read<DBService>(), MainService.create())),
                          child: BrancheDialogComp(param: param),
                        );
                      },
                    );
                  },
                  title: "send_complaint".tr(),
                ),
              ),
              80.h.verticalSpace,
            ],
          ),
        ),
      );
    });
  }
}
