import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/application/auth/controller/registration_view_model.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/dialog_title.dart';
import 'package:mpd_client/presentation/pages/auth/widgets/sheets/region_list_view.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_scale_animation.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';

class WSelectRegionBottomSheet extends StatefulWidget {
  const WSelectRegionBottomSheet({super.key});

  @override
  State<WSelectRegionBottomSheet> createState() => _WSelectRegionBottomSheetState();
}

class _WSelectRegionBottomSheetState extends State<WSelectRegionBottomSheet> {
  late PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
      child: SizedBox(
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, state) {
              return SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const DialogTitle(title: "Tug'ilgan joyingizni tanlang"),
                            const SizedBox(height: 16),
                            WTextField(
                              style: context.textTheme.bodyLarge!.copyWith(
                                color: white,
                              ),
                              onChanged: (value) {
                                context.read<AccountsBloc>().add(GetRegion(search: value));
                              },
                              hintText: "Search",
                              borderColor: borderColor,
                              fillColor: white.withOpacity(0.2),
                              // prefixIcon: Padding(
                              //   padding: const EdgeInsets.only(right: 8),
                              //   child: AppIcons.icHome.svg(color: gray),
                              // ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      if ($regVM().pageInTitle.isNotEmpty)
                        WScaleAnimation(
                          onTap: () {
                            if ($regVM().pageInTitle.length > 1) {
                              if (controller.hasClients) {
                                controller.animateToPage(
                                  controller.page!.toInt() - 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                              $regVM().selectPag(
                                context,
                                controller.page!.toInt() - 1,
                                "",
                                $regVM().pageInTitle[controller.page!.toInt()].id,
                              );
                            } else if (controller.hasClients) {
                              controller.animateToPage(
                                controller.page!.toInt() - 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                              $regVM().selectPag(context, 0, "", 0);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 24,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: const Icon(
                              Icons.arrow_left,
                              color: white,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 460,
                        child: PageView(
                          controller: controller,
                          children: [
                            RegionListView(
                              regions: state.regionAndProfessionContainer.regions,
                              controller: controller,
                              index: 1,
                              isLoading: state.regionAndProfessionContainer.statusd.isInProgress,
                            ),
                            RegionListView(
                              regions: state.regionAndProfessionContainer.regions1,
                              controller: controller,
                              index: 2,
                              isLoading: state.regionAndProfessionContainer.statusd.isInProgress,
                            ),
                            RegionListView(
                              regions: state.regionAndProfessionContainer.regions2,
                              controller: controller,
                              index: 2,
                              isLoading: state.regionAndProfessionContainer.statusd.isInProgress,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
