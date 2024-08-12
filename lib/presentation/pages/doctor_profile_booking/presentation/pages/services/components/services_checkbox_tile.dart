import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpd_client/application/product_specalist/product_specalist_bloc.dart';
import 'package:mpd_client/domain/models/lenta/specialist_product_model.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/app_images.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/utils/utils.dart';

class ServicesCheckBoxTile extends StatelessWidget {
  final ValueChanged onChanged;
  final bool value;
  final SpecialistProduct product;
  final int count;
  final VoidCallback onPlus, onMinus;
  const ServicesCheckBoxTile({
    super.key,
    required this.onChanged,
    required this.count,
    required this.value,
    required this.product,
    required this.onPlus,
    required this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(blurRadius: 15, color: cardShadow)],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        color: product.remains == 0 ? Colors.red.shade100 : Colors.white,
        child: Stack(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              contentPadding: EdgeInsets.zero,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      AppImages.service,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ScreenUtil().setHorizontalSpacing(16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 230.w),
                        child: Text(
                          product.product.name,
                          style: Styles.descSubtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      ScreenUtil().setVerticalSpacing(4.h),
                      Text(product.price.isNotEmpty ? '${Utils.priceFormat(product.price.first.value)} ${Utils.currencyFormat(product.price.first.currency)}' : "--",
                          style: Styles.headline7Sp14.copyWith(color: mainBlue)),
                    ],
                  )
                ],
              ),
              visualDensity: const VisualDensity(vertical: 4, horizontal: -4),
              leading: Checkbox(
                activeColor: mainBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                onChanged: product.remains == 0 ? (_) {} : onChanged,
                value: value,
              ),
            ),
            Positioned(
              bottom: 9,
              right: 16,
              child: AnimatedCrossFade(
                firstChild: const SizedBox(),
                secondChild: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      splashRadius: 20,
                      onPressed: onMinus,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        AppIcons.minus,
                        colorFilter: ColorFilter.mode(mainBlue, BlendMode.srcIn),
                      ),
                    ),
                    ScreenUtil().setHorizontalSpacing(8.w),
                    Text(
                      count.toString(),
                      style: Styles.headline7Sp14.copyWith(color: mainBlue),
                    ),
                    ScreenUtil().setHorizontalSpacing(8.w),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                      onPressed: onPlus,
                      icon: SvgPicture.asset(
                        AppIcons.plus,
                        colorFilter: ColorFilter.mode(mainBlue, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                crossFadeState: !context.read<ProductSpecalistBloc>().contains(id: product.id) ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*
Material(
        borderRadius: BorderRadius.circular(12.r),
        color: white,
        child: CheckboxListTile(
      
          
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          visualDensity: const VisualDensity(horizontal: -4, vertical: 4),
          checkboxShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
          controlAffinity: ListTileControlAffinity.leading,
          title: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(AppImages.service,
                      height: 40.h, width: 40.h)),
              ScreenUtil().setHorizontalSpacing(16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dental treatment ',
                    style: Styles.descSubtitle,
                  ),
                  Text(
                    '50 000 UZS',
                    style: Styles.boldHeadline6.copyWith(
                        color: mainBlue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
          onChanged: onChanged,
          value: value,
        ),
      ),


 */
