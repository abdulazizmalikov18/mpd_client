import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/gallery_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class DesignWidget extends StatelessWidget {
  const DesignWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.designModel;
            if (state.statusDesign == FormzSubmissionStatus.inProgress) {
              return const ReviewShimmerComp();
            }
            return ListView(
              shrinkWrap: true,
              children: [
                16.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StarsComp(
                    starCount: model?.ratedByOrientMotors ?? 0,
                    title: "design".tr(),
                  ),
                ),
                ..._buildDesignShape(
                  title: "exterior_design".tr(),
                  label: model?.externalDesign ?? "",
                  img: (model?.externalPhotos)?.toList() ?? const [],
                  context: context,
                ),
                ..._buildDesignShape(
                  title: "interior_design".tr(),
                  label: model?.interiorDesign ?? "",
                  img: (model?.interiorPhotos)?.toList() ?? const [],
                  context: context,
                ),
                const ReviewCarsComp(),
                const PolicyComp(),
                36.verticalSpace,
              ],
            );
          },
        );
      },
    );
  }

  List<Widget> _buildDesignShape({
    required String title,
    required String label,
    required List<String> img,
    required BuildContext context,
  }) {
    return [
      12.verticalSpace,
      Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: Style.medium14(),
        ),
      ),
      GalleryGridComp(
        images: img,
        onTap: () {
          Navigator.push(
            context,
            AppRoutes.getGalleryDetail(
                images:
                    img.map((e) => ImagesModel((b) => b..url = e)).toList()),
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 8),
        child: Text(
          label,
          style: Style.medium14(color: Colors.black54),
        ),
      ),
      Divider(color: Colors.grey.shade300, indent: 16, endIndent: 16),
    ];
  }
}
