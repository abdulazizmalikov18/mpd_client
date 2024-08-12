import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mpd_client/application/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/presentation/pages/appointment/widgets/pinned_sheet.dart';
import 'package:mpd_client/presentation/router/routs_contact.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_long_button.dart';
import 'package:mpd_client/utils/extensions/context_extension.dart';
import 'package:mpd_client/utils/utils.dart';

class ServicePinnedSheet extends StatelessWidget {
  final int specialistId;
  const ServicePinnedSheet({super.key, required this.specialistId});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    return PinnedSheet(
        verticalPadding: 0,
        widget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ProductSpecalistBloc, ProductSpecalistState>(
              builder: (context, state) {
                if (state.localProducts.isNotEmpty) {
                  total = 0;
                  for (var e in state.localProducts) {
                    total += e.count * e.price;
                  }
                }
                return AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.maxFinite),
                  secondChild: Padding(
                    padding: EdgeInsets.only(bottom: 16.h, top: 14.h),
                    child: Row(
                      children: [
                        Text('${state.localProducts.length} ${context.l10n.book_appointment_selected}', style: Styles.descSubtitle.copyWith(color: grey)),
                        const Spacer(),
                        Text("${Utils.priceFormat(total)} UZS", style: Styles.headline4.copyWith(fontFamily: Styles.gilroyMedium, color: black))
                      ],
                    ),
                  ),
                  crossFadeState: state.localProducts.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 400),
                );
              },
            ),
            BlocBuilder<ProductSpecalistBloc, ProductSpecalistState>(
              builder: (context, state) {
                return AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.maxFinite),
                  secondChild: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom + 14,
                    ),
                    child: LongButton(
                      buttonName: context.l10n.book_appointment_next,
                      onPress: () {
                        context.pushNamed(
                          AppRouteNames.appointmentdt,
                          extra: {
                            "id": specialistId,
                            "product": state.localProducts,
                          },
                        );
                        // FIXME: NavigateTo
                        // Navigator.of(context).pushNamed(
                        //   AppRoutes.appointmentdt,
                        //   arguments: {
                        //     "id": specialistId,
                        //     "product": state.localProducts,
                        //   },
                        // );
                      },
                    ),
                  ),
                  crossFadeState: state.localProducts.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ));
  }
}
