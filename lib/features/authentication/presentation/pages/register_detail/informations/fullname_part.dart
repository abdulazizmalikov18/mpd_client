import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/app/app_routes.dart';
import 'package:mpd_client/core/validator/validators.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/bloc/profession_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/change_password/change_password_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/check_username/check_username_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/create_user/create_user_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/district/district_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/region/region_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/sub_profession/sub_professions_bloc.dart';
import 'package:mpd_client/features/authentication/domain/inherited/auth_notifier.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/select_date_widget.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/select_gender_widget.dart';
import 'package:mpd_client/features/authentication/presentation/widgets/have_account_text_widget.dart';
import 'package:mpd_client/provider/language.dart';
import 'package:mpd_client/src/tools/ui_tools.dart';
import 'package:mpd_client/src/widgets/label_input_widget.dart';
import 'package:mpd_client/src/themes/styles.dart';
import 'package:mpd_client/src/widgets/loading_dialog_widget.dart';
import 'package:mpd_client/src/widgets/longbutton.dart';

class FullnamePart extends StatefulWidget {
  final String phone;
  const FullnamePart({super.key, required this.phone});

  @override
  State<FullnamePart> createState() => _FullnamePartState();
}

class _FullnamePartState extends State<FullnamePart> {
  @override
  void initState() {
    context.read<RegionBloc>().add(GetRegionsEvent());
    context.read<ProfessionBloc>().add(GetProfessionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ScreenUtil().setVerticalSpacing(24.h),
        Center(
          child: Text(
            context.l10n.register_user_info,
            textAlign: TextAlign.center,
            style: Styles.boldTitle.copyWith(color: context.color.black),
          ),
        ),
        Form(
          key: context.read<CreateUserBloc>().formKey,
          child: Column(
            children: [
              ScreenUtil().setVerticalSpacing(32.h),
              BlocBuilder<CheckUsernameBloc, CheckUsernameState>(
                builder: (context, state) {
                  return LabelInputWidget(
                      require: '*',
                      errorText: getFailure(state, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => Validators.username(value, context),
                      textInputAction: TextInputAction.next,
                      controller:
                          context.read<CreateUserBloc>().userNameController,
                      topHint: context.l10n.register_login,
                      inputHint: context.l10n.register_login,
                      onChanged: (text) {
                        context
                            .read<CheckUsernameBloc>()
                            .add(CheckUsername(text));
                      },
                      suffixIcon: getStatus(state));
                },
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              LabelInputWidget(
                require: '*',
                validator: (value) => Validators.empty(value, context),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: context.read<CreateUserBloc>().firsNameController,
                topHint: context.l10n.register_firstname,
                inputHint: context.l10n.register_firstname,
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              LabelInputWidget(
                require: '*',
                validator: (value) => Validators.empty(value, context),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: context.read<CreateUserBloc>().lastNameController,
                topHint: context.l10n.register_lastname,
                inputHint: context.l10n.register_lastname,
              ),
              ScreenUtil().setVerticalSpacing(20.h),
              SelectDateWidget(
                  birthController:
                      context.read<CreateUserBloc>().birthController),
            ],
          ),
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        const SelectGenderWidget(),
        // ScreenUtil().setVerticalSpacing(20.h),
        // BlocSelector<ProfessionBloc, ProfessionState, Profession?>(
        //   selector: (state) => state.chosenProfession,
        //   builder: (context, chosenProfession) {
        //     Profession? chosen = chosenProfession;
        //     return BlocSelector<SubProfessionsBloc, SubProfessionsState,
        //         Profession?>(
        //       selector: (state) => state.selectedSubProfession,
        //       builder: (context, selectedSubProfession) {
        //         chosen = chosenProfession ?? selectedSubProfession;
        //         return SelectVariantsWidget(
        //           topHint: context.l10n.register_profession,
        //           hint: chosen != null
        //               ? chosen!.name!
        //               : context.l10n.register_profession_title,
        //           onPressed: () {
        //             FocusScope.of(context).unfocus();
        //             showModalBottomSheet(
        //               useSafeArea: true,
        //               backgroundColor: Colors.transparent,
        //               isScrollControlled: true,
        //               context: context,
        //               builder: (ctx) => _buildProfessionSheet(context),
        //             );
        //           },
        //         );
        //       },
        //     );
        //   },
        // ),
        // ScreenUtil().setVerticalSpacing(20.h),
        // BlocSelector<DistrictBloc, DistrictState, Region?>(
        //   selector: (state) => state.selectedDistict,
        //   builder: (context, selectedDistict) {
        //     return SelectVariantsWidget(
        //       onPressed: () {
        //         FocusScope.of(context).unfocus();

        //         showModalBottomSheet(
        //           useSafeArea: true,
        //           backgroundColor: Colors.transparent,
        //           isScrollControlled: true,
        //           context: context,
        //           builder: (ctx) => _buildRegionSheet(context),
        //         );
        //       },
        //       topHint: context.l10n.register_region,
        //       hint: selectedDistict != null
        //           ? selectedDistict.name
        //           : context.l10n.register_region_title,
        //     );
        //   },
        // ),

        ScreenUtil().setVerticalSpacing(32.h),
        BlocSelector<ProfessionBloc, ProfessionState, Profession?>(
          selector: (state) => state.chosenProfession,
          builder: (context, chosenProfession) {
            Profession? chosen = chosenProfession;
            return BlocSelector<SubProfessionsBloc, SubProfessionsState,
                Profession?>(
              selector: (state) => state.selectedSubProfession,
              builder: (context, selectedSubProfession) {
                chosen = chosenProfession ?? selectedSubProfession;
                return BlocListener<CreateUserBloc, CreateUserState>(
                  listener: (context, state) async {
                    if (state.showLoading) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const LoadingDialogWidget());
                    }

                    if (!state.showLoading && state.error == 'No') {
                      // Navigator.pop(context);
                      await Future.delayed(const Duration(milliseconds: 250))
                          .then(
                        (value) {
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.mainPage,
                              (route) => false,
                            );
                          }
                        },
                      );
                    } else if (!state.showLoading &&
                        state.error != 'No' &&
                        state.error != '') {
                      // Navigator.pop(context);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(UiTools.failSnackbar(
                            title: state.error, context: context));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: LongButton(
                        buttonName: context.l10n.register_register,
                        onPress: () {
                          FocusScope.of(context).unfocus();

                          final region = context
                              .read<DistrictBloc>()
                              .state
                              .selectedDistict;
                          context.read<CreateUserBloc>().add(ForCreateUserEvent(
                              phone: widget.phone,
                              password: context
                                  .read<ChangePasswordBloc>()
                                  .password2Controller
                                  .text,
                              mainCategory: chosen?.id,
                              region: region?.id));
                          AuthInheritedNotifier.of(context)
                              .notifier!
                              .topScroll();
                        }),
                  ),
                );
              },
            );
          },
        ),
        ScreenUtil().setVerticalSpacing(20.h),
        HaveAccountTextWidget(
          info: context.l10n.register_have_account,
          buttonText: context.l10n.login_enter,
          onPressed: () {
            FocusScope.of(context).unfocus();

            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.auth, (route) => false);
          },
        ),
        ScreenUtil().setVerticalSpacing(40.h),
      ],
    );
  }

  String? getFailure(CheckUsernameState state, BuildContext context) {
    if (state is CheckUsernameFailure) {
      return state.failure;
    } else if (state is CheckUsernameSuccess && state.isExist) {
      return context.l10n.register_error_code_username_exist;
    } else {
      return null;
    }
  }

  Widget getStatus(CheckUsernameState state) {
    if (state is CheckUsernameInitial) {
      return const SizedBox();
    } else if (state is CheckUsernameLoading) {
      return Transform.scale(
        scale: .5,
        child: const CircularProgressIndicator(),
      );
    } else if (state is CheckUsernameSuccess) {
      if (state.isExist) return Icon(Icons.close, color: context.color.red);
      return Icon(Icons.check, color: context.color.green);
    } else {
      return Icon(Icons.close, color: context.color.red);
    }
  }

  // MultiBlocProvider _buildProfessionSheet(BuildContext context) {
  //   return MultiBlocProvider(
  //       providers: [
  //         // BlocProvider.value(value: BlocProvider.of<ProfessionsBloc>(context)),
  //         BlocProvider.value(value: BlocProvider.of<ProfessionBloc>(context)),
  //         BlocProvider.value(
  //             value: BlocProvider.of<SubProfessionsBloc>(context))
  //       ],
  //       child: OpenCloseExpansionInheritedNotifier(
  //           openCloseNotifier: OpenCloseNotifier(),
  //           child: const ProfessionSheet()));
  // }

  // MultiBlocProvider _buildRegionSheet(BuildContext context) {
  //   return MultiBlocProvider(providers: [
  //     BlocProvider.value(value: BlocProvider.of<RegionBloc>(context)),
  //     BlocProvider.value(value: BlocProvider.of<DistrictBloc>(context))
  //   ], child: const RegionSheet());
  // }
}
