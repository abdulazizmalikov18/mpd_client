import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';
import 'package:mpd_client/src/widgets/pinned_sheet.dart';

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
                          Text(
                              '${state.localProducts.length} ${context.l10n.book_appointment_selected}',
                              style: Styles.descSubtitle
                                  .copyWith(color: context.color.grey)),
                          const Spacer(),
                          Text("${Utils.priceFormat(total)} UZS",
                              style: Styles.headline4.copyWith(
                                  fontFamily: Styles.gilroyMedium,
                                  color: context.color.black))
                        ],
                      ),
                    ),
                    crossFadeState: state.localProducts.isEmpty
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 400));
              },
            ),
            BlocBuilder<ProductSpecalistBloc, ProductSpecalistState>(
              builder: (context, state) {
                return AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.maxFinite),
                  secondChild: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewPadding.bottom + 14.h,
                    ),
                    child: LongButton(
                        buttonName: context.l10n.book_appointment_next,
                        onPress: () {
                          if (specialistId == 0) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.appointmentReview,
                              arguments: {
                                "isOffering": true,
                                "product": state.localProducts,
                              },
                            );
                          } else {
                            Navigator.of(context).pushNamed(
                              AppRoutes.appointmentdt,
                              arguments: {
                                "id": specialistId,
                                "product": state.localProducts,
                              },
                            );
                          }
                        }),
                  ),
                  crossFadeState: state.localProducts.isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),
          ],
        ));
  }
}
