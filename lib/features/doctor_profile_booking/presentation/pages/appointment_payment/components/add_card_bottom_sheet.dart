import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mpd_client/core/utils/ticker.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/insert_card/insert_card_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/resend_verify_card/resend_verify_card_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/domain/blocs/verify_card/verify_card_bloc.dart';
import 'package:mpd_client/features/doctor_profile_booking/presentation/pages/appointment_payment/components/verification_card_sheet.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';

import '../../../../../../app/app_colors.dart';
import '../../../../../../app/app_export.dart';
import '../../../../../../src/themes/styles.dart';
import '../../../../../../src/widgets/bottom_sheet_widget.dart';
import '../../../../../../src/widgets/label_input_widget.dart';
import '../../../../../../src/widgets/longbutton.dart';

class AddCardBotomSheet extends StatelessWidget {
  final BuildContext contextCons;
  const AddCardBotomSheet({super.key, required this.contextCons});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InsertCardBloc, InsertCardState>(
      listener: (ctx, state) {
        if (state is InsertCardLoading) {
          //? When in progress
          FocusScope.of(context).unfocus();
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => const LoadingDialogWidget(),
          );
        } else if (state is InsertCardSuccess) {
          //? Have to verify
          Navigator.pop(context);
          Navigator.pop(context);
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: ctx,
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      VerifyCardBloc(locator.get<DoctorProfileRepository>()),
                ),
                BlocProvider(
                  create: (context) => ResendVerifyCardBloc(
                    locator.get<DoctorProfileRepository>(),
                    const Ticker(),
                  ),
                ),
                BlocProvider.value(
                  value: BlocProvider.of<MyCardsBloc>(contextCons),
                ),
              ],
              child: VerificationCardSheet(id: state.card!.id!),
            ),
            isScrollControlled: true,
          );
        } else if (state is InsertCardFailure) {
          //? When have a error
          Navigator.pop(context);
        }
      },
      child: Form(
        key: context.read<InsertCardBloc>().formkey,
        child: BottomSheetWidget(
          children: [
            ScreenUtil().setVerticalSpacing(32.h),
            Center(
              child: Text(
                'Add card',
                style: Styles.boldTitle.copyWith(
                  color: context.color.black,
                  fontSize: 24.sp,
                  fontFamily: Styles.gilroyMedium,
                ),
              ),
            ),
            ScreenUtil().setVerticalSpacing(32.h),
            BlocBuilder<InsertCardBloc, InsertCardState>(
              builder: (context, state) {
                return LabelInputWidget(
                  topHint: 'Card number',
                  inputHint: '0000 0000 0000 0000',
                  validator: Validators.cardNumber,
                  errorText: state is InsertCardFailure ? state.failure : null,
                  textInputType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputformater: [
                    MaskTextInputFormatter(
                      mask: '#### #### #### ####',
                      filter: {"#": RegExp(r'[0-9]')},
                    ),
                  ],
                  textInputAction: TextInputAction.next,
                  controller: context.read<InsertCardBloc>().cardController,
                  require: '*',
                );
              },
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            LabelInputWidget(
              topHint: 'Expiry',
              inputHint: 'mm/yy',
              textInputType: TextInputType.number,
              validator: Validators.expiryNumber,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputformater: [
                MaskTextInputFormatter(
                  mask: '##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                ),
              ],
              textInputAction: TextInputAction.next,
              controller: context.read<InsertCardBloc>().expiryController,
              require: '*',
            ),
            ScreenUtil().setVerticalSpacing(20.h),
            LabelInputWidget(
              topHint: 'Card name',
              inputHint: 'Card name',
              validator: (value) => Validators.empty(value, context),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: context.read<InsertCardBloc>().nameController,
            ),
            ScreenUtil().setVerticalSpacing(32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LongButton(
                buttonName: 'Add',
                onPress: () {
                  context.read<InsertCardBloc>().add(InsertCard());
                },
              ),
            ),
            ScreenUtil().setVerticalSpacing(32.h),
          ],
        ),
      ),
    );
  }
}
