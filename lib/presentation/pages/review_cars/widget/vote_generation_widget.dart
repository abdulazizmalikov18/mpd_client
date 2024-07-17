import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/review/review_bloc.dart';
import 'package:orient_motors/domain/models/review/review_model.dart';
import 'package:orient_motors/presentation/component/animation_effect.dart';
import 'package:orient_motors/presentation/component/cached_image_component.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/debounce.dart';

class VoteGenerationWidget extends StatelessWidget {
  final ReviewFilterReq model;
  final bool asPage;
  const VoteGenerationWidget(
      {super.key, required this.model, this.asPage = false});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return Material(
          color: asPage ? Colors.white : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ReviewBloc, ReviewState>(
              builder: (context, state) {
                final item =
                    state.idEither?.votingGeneration ?? VotingGeneration();

                return Column(
                  children: [
                    if (asPage) ...[
                      SafeArea(
                        bottom: false,
                        child: 0.verticalSpace,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: icons.back.svg()),
                      )
                    ],
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: CachedImageComponent(
                          imageUrl: item.icon ?? "",
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    icons.hourglass.svg(height: 40),
                    8.verticalSpace,
                    Text(
                      "im_sorry_Information_about_the_car_will_be_provided"
                          .tr(),
                      style: fonts.headline2,
                      textAlign: TextAlign.center,
                    ),
                    4.verticalSpace,
                    Text(
                      "vehicle_information_is_being_prepared_for_evaluation"
                          .tr(),
                      style: Style.medium14(size: 12),
                      textAlign: TextAlign.center,
                    ),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimationButtonEffect(
                          onTap: () {
                            onDebounce(() {
                              context.read<ReviewBloc>().add(
                                    ReviewEvent.voteGeneration(
                                      id: item.generationId ?? 0,
                                      onDone: () {
                                        if (asPage) {
                                          context.read<ReviewBloc>().add(
                                              ReviewEvent.getId(model: model));
                                        } else {
                                          context.read<ReviewBloc>().add(
                                              ReviewEvent.getListFilter(
                                                  model: model));
                                        }
                                      },
                                    ),
                                  );
                            });
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: colors.customRed),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  icons.fingerForward.svg(height: 18),
                                  8.horizontalSpace,
                                  Text("voting".tr(),
                                      style: fonts.caption.copyWith(
                                          color: colors.customRed,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.2, color: colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            child: Text(item.generationVotes.toString(),
                                style: fonts.caption.copyWith(
                                    color: colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
