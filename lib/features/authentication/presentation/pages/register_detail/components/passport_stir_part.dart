import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_export.dart';
import 'package:mpd_client/app/app_icons.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class PassportStirPart extends StatelessWidget {
  const PassportStirPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ScreenUtil().setVerticalSpacing(24.h),
        Text(
          'Ты должен пройти полную модерацию',
          textAlign: TextAlign.center,
          style: Styles.boldTitle,
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        Form(
          key: context.read<PassportBloc>().formKey,
          child: LabelInputWidget(
            require: '*',
            inputformater: [
              MaskTextInputFormatter(mask: '# ###### ### ### #', filter: {"#": RegExp(r'[0-9]')})
            ],
            validator: Validators.passportSTIR,
            textInputType: TextInputType.number,
            controller: context.read<PassportBloc>().stirController,
            topHint: 'Pasport',
            inputHint: 'Pasport STIR',
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload pasport*',
                style: Styles.headline7Bold.copyWith(color: context.color.red),
              ),
              ScreenUtil().setVerticalSpacing(8.h),
              InkWell(
                onTap: () {
                  context.read<PassportBloc>().add(SelectPassportImage());
                },
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: context.color.border), borderRadius: BorderRadius.circular(10.r)),
                  child: Row(
                    children: [
                      ScreenUtil().setHorizontalSpacing(15.w),
                      BlocSelector<PassportBloc, PassportState, File?>(
                        selector: (state) => state.pasportImage,
                        builder: (context, image) {
                          return Text(
                            image != null ? image.path.split('/').last : '123456789.JPEG',
                            style: Styles.headline7.copyWith(color: context.color.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          );
                        },
                      ),
                      const Spacer(),
                      SvgPicture.asset(AppIcons.documentUpload, height: 22.h),
                      ScreenUtil().setHorizontalSpacing(15.w)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(32.h),
        BlocConsumer<PassportBloc, PassportState>(
          listener: (context, state) async {
            if (state.showLoading) {
              showDialog(context: context, barrierDismissible: true, builder: (context) => const LoadingDialogWidget());
            }

            if (!state.showLoading && state.error == 'No') {
              Navigator.pop(context);

              await Future.delayed(const Duration(milliseconds: 300))
                  .then((value) => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainPage, (route) => false));
            } else if (!state.showLoading && state.error != 'No' && state.error != '') {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(UiTools.failSnackbar(title: state.error, context: context));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LongButton(
                isDisable: state.pasportImage == null,
                buttonName: 'Register',
                onPress: () {
                  context.read<PassportBloc>().add(UpdatePersonalDataEvent());
                },
              ),
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Later!', style: Styles.headline6.copyWith(color: context.color.black, fontWeight: FontWeight.w500)),
              ScreenUtil().setHorizontalSpacing(5.w),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainPage, (route) => false);
                },
                customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Skip',
                    style: Styles.headline6.copyWith(color: context.color.mainBlue, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(40.h),
      ],
    );
  }
}
