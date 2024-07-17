import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/presentation/pages/review_cars/comp/stars_comp.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ImagePartComp extends StatelessWidget {
  const ImagePartComp({super.key, required this.title, this.maxLine});

  final String title;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    final model = context.read<ReviewBloc>().state.systhesisModel;
    final designModel = context.read<ReviewBloc>().state.designModel;
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.zero,
          constraints: const BoxConstraints(minHeight: 230),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(model?.photo ?? ""),
            ),
          ),
          child: ColoredBox(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Style.medium20(size: 18.sp, color: colors.white),
                    maxLines: maxLine,
                  ),
                  16.verticalSpace,
                  StarsComp(
                    starCount: designModel?.ratedByOrientMotors ?? 0,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
