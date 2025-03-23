import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/presentation/paginator_list.dart';
import 'package:mpd_client/features/home/data/models/local_service_model.dart';
import 'package:mpd_client/features/home/data/models/specialist_product_model.dart';
import 'package:mpd_client/features/home/domain/blocs/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/features/home/presentation/widgets/build_label.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/services/components/services_checkbox_tile.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ServiceSuccess extends StatelessWidget {
  final List<LocalService> localProducts;
  final List<SpecialistProduct> specialistProducts;
  final bool hasMoreToFetch;
  final VoidCallback fetchMoreFunction;
  final FormzSubmissionStatus paginatorStatus;

  const ServiceSuccess({
    super.key,
    required this.specialistProducts,
    required this.hasMoreToFetch,
    required this.fetchMoreFunction,
    required this.paginatorStatus,
    required this.localProducts,
  });

  @override
  Widget build(BuildContext context) {
    if (specialistProducts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(AppIcons.serviceEmpty),
          ScreenUtil().setVerticalSpacing(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            child: Text('The doctor does not have any type of service',
                textAlign: TextAlign.center, style: Styles.emptyboldTitle),
          )
        ],
      );
    }
    return Column(
      children: [
        ScreenUtil().setVerticalSpacing(12.h),
        BuildLabel(label: context.l10n.book_appointment_select),
        ScreenUtil().setVerticalSpacing(12.h),
        Expanded(
          child: PaginatorList(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            paginatorStatus: paginatorStatus,
            itemBuilder: (context, index) {
              final product = specialistProducts[index];

              if (product.remains == 0) {
                return const SizedBox();
              }

              return Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: context.color.mainBlue,
                ),
                child: ServicesCheckBoxTile(
                  onMinus: () {
                    context
                        .read<ProductSpecalistBloc>()
                        .add(DicrementProductEvent(id: product.id, count: 1));
                  },
                  onPlus: () {
                    context
                        .read<ProductSpecalistBloc>()
                        .add(IncrementProductEvent(id: product.id, count: 1));
                  },
                  count: localCount(product.id),
                  product: product,
                  value: context
                      .read<ProductSpecalistBloc>()
                      .contains(id: product.id),
                  onChanged: (value) {
                    context
                        .read<ProductSpecalistBloc>()
                        .add(InsertProductEvent(product));
                  },
                ),
              );
            },
            itemCount: specialistProducts.length,
            fetchMoreFunction: () {
              fetchMoreFunction();
            },
            hasMoreToFetch: hasMoreToFetch,
          ),
          // child: SingleChildScrollView(
          //   child: Column(
          //     children: List.generate(
          //       specialistProducts.length,
          //       (index) {
          //         int? selectedCount;
          //         final product = specialistProducts[index];

          //         if (product.remains == 0) {
          //           return const SizedBox();
          //         }

          //         return Theme(
          //           data: Theme.of(context).copyWith(
          //             unselectedWidgetColor: context.color.mainBlue,
          //           ),
          //           child: ServicesCheckBoxTile(
          //             onMinus: () {
          //               context.read<SpecialistProductBloc>().add(
          //                   DicrementProductEvent(id: product.id, count: 1));
          //             },
          //             onPlus: () {
          //               context.read<SpecialistProductBloc>().add(
          //                   IncrementProductEvent(id: product.id, count: 1));
          //             },
          //             count: selectedCount ?? 0,
          //             product: product,
          //             value: context
          //                 .read<SpecialistProductBloc>()
          //                 .contains(id: product.id),
          //             onChanged: (value) {
          //               context
          //                   .read<SpecialistProductBloc>()
          //                   .add(InsertProductEvent(product));
          //             },
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  int localCount(int id) {
    if (localProducts.isNotEmpty) {
      for (var e in localProducts) {
        if (e.id == id) {
          return e.count;
        }
      }
    }
    return 0;
  }
}
