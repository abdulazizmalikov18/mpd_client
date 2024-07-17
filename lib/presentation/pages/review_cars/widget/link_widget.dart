import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/pages/home/comp/policy_comp.dart';
import 'package:orient_motors/presentation/pages/home/comp/review_cars_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/review_shimmer_comp.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            final model = state.linkModel;
            final rating =
                state.safetyConvenienceModel?.ratedByOrientMotors ?? 0;
            if (state.statusLink == FormzSubmissionStatus.inProgress ||
                state.statusLink == FormzSubmissionStatus.initial) {
              return const ReviewShimmerComp();
            }
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: StarsComp(
                    starCount: rating,
                    title: "link".tr(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.network(
                    model?.brand?.icon ?? "",
                    height: 62.h,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                if (model?.brandUrl != null)
                  _buildLinker(model?.brand?.name ?? "", model!.brandUrl!),
                8.verticalSpace,
                if (model?.serviceCenterUrl != null)
                  _buildLinker(
                      "service_center_url".tr(), model!.serviceCenterUrl!),
                8.verticalSpace,
                if (model?.exhibitionInfoUrl != null)
                  _buildLinker(
                      "exhibition_info_url".tr(), model!.exhibitionInfoUrl!),
                8.verticalSpace,
                const ReviewCarsComp(),
                const PolicyComp(),
                20.verticalSpace,
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildLinker(String title, String url) {
    return ThemeWrapper(builder: (context, CustomColorSet colors, FontSet fonts,
        IconSet icons, GlobalController controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.medium14(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(url));
                },
                child: Text(
                  url,
                  style: Style.medium14(color: colors.grey88).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
