import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/application/auth/auth_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/apis/apis.dart';
import 'package:orient_motors/infrastructure/repositories/auth_repo.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/presentation/component/custom_button.dart';
import 'package:orient_motors/presentation/pages/create/comp/contact_time_comp.dart';
import 'package:orient_motors/presentation/pages/create/comp/phone_add_comp.dart';
import 'package:orient_motors/presentation/pages/create/comp/select_region_comp.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class ContactInfoWidget extends StatefulWidget {
  const ContactInfoWidget({super.key});

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (ctx, colors, fonts, icons, controller) {
        return BlocConsumer<AddCarBloc, AddCarState>(
            listenWhen: (previous, current) {
          return (previous.createCarSuccess != current.createCarSuccess &&
              current.createCarSuccess);
        }, listener: (context, state) {
          if (state.createCarSuccess) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                    create: (_) => AuthBloc(AuthRepository(
                          context.read<DBService>(),
                          AuthService.create(),
                        )),
                    child: const PhoneAddComp()),
                Divider(color: colors.customGreyC3),
                16.verticalSpace,
                if (state.createCarReq != null &&
                    (state.regionList ?? []).isNotEmpty)
                  SelectRegionComp(
                    regionId: state.createCarReq?.region,
                    formKey: formKey,
                    regions: state.regionList ?? [],
                    onRegionSelected: (NamedModel region) {
                      CreateCarReq req = (state.createCarReq ?? CreateCarReq())
                          .rebuild((p0) => p0..region = region.id);
                      context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
                          createCarReq: req, filterType: FilterType.none));
                    },
                  ),
                16.verticalSpace,
                Divider(color: colors.customGreyC3),
                16.verticalSpace,
                const ContactTimeComp(),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context
                          .read<AddCarBloc>()
                          .add(const AddCarEvent.checkData(isCreate: true));
                    }
                  },
                  backgroundColor: colors.primary,
                  title:
                      state.postId != null ? "republish".tr() : "publish".tr(),
                  verticalPadding: 13.h,
                ),
                16.verticalSpace,
                if (state.postId == null)
                  Center(
                      child: TextButton(
                          onPressed: () {
                            context
                                .read<AddCarBloc>()
                                .add(const AddCarEvent.createDraftCar());
                          },
                          child: Text(
                            "save_to_draft".tr(),
                            style: fonts.subtitle1,
                          ))),
                80.verticalSpace
              ],
            ),
          );
        });
      },
    );
  }
}
