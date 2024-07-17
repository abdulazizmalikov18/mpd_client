import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/add_car/add_car_bloc.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/presentation/component/custom_dialog_component.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/basic_information_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/body_type_select_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/brand_select_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/contact_info.dart';
import 'package:orient_motors/presentation/pages/create/widget/description_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/model_select_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/modification_select_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/option_widget_add_car.dart';
import 'package:orient_motors/presentation/pages/create/widget/photo_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/position_select_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/price_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/replaced_parts_widget.dart';
import 'package:orient_motors/presentation/pages/create/widget/year_of_manufacture_select_widget.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/constants.dart';
import 'package:orient_motors/utils/enum_filtr.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> with TickerProviderStateMixin {
  late bool canPop;
  late TabController _tabController;

  void changeTap(CreateCarReq? createCarReq, int index) {
    FilterType type;
    switch (index) {
      case 0:
        type = FilterType.brand;
        break;
      case 1:
        type = FilterType.model;
        break;
      case 2:
        type = FilterType.generation;
        break;
      case 3:
        type = FilterType.modification;
        break;
      case 4:
        type = FilterType.year;
        break;
      case 5:
        type = FilterType.bodyType;
        break;
      case 6:
        type = FilterType.carOptions;
        break;
      case 7:
        type = FilterType.configurations;
        break;
      case 8:
        type = FilterType.replacedParts;
        break;
      case 9:
        type = FilterType.price;
        break;
      case 10:
        type = FilterType.photography;
        break;
      case 11:
        type = FilterType.description;
        break;
      case 12:
        type = FilterType.contact;
        break;
      default:
        type = FilterType.brand;
        break;
    }
    context.read<AddCarBloc>().add(AddCarEvent.setFilterValue(
        createCarReq: createCarReq ?? CreateCarReq(),
        filterType: type,
        isCheck: false));
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  void initState() {
    _tabController =
        TabController(length: listAddCarTabbar.length, vsync: this);
    Future.delayed(Duration.zero, () {
      context.read<BottomNavBarController>().changeNavBar(true);
    });
    canPop = false;
    super.initState();
  }

  void showDraftDialog(
      BuildContext context, CreateCarReq? createCarReq, bool isEdit) {
    canPop = true;
    if (createCarReq?.brand == null || isEdit) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return CustomDialogComponent(
                isRightPop: true,
                title: "save_to_draft".tr(),
                content: 'save_to_draft_desc'.tr(),
                leftButtonTitle: "cancel".tr(),
                rightButtonTitle: "save".tr(),
                onLeftButtonPressed: () {
                  Navigator.of(context).pop();
                },
                onRightButtonPressed: () {
                  context
                      .read<AddCarBloc>()
                      .add(const AddCarEvent.createDraftCar());
                });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return OnUnFocusTap(
        child: BlocConsumer<AddCarBloc, AddCarState>(
            listenWhen: (previous, current) {
          return (current.index != _tabController.index) ||
              (current.createDraftCarSuccess !=
                      previous.createDraftCarSuccess ||
                  current.createDraftCarSuccess);
        }, listener: (context, state) {
          if (state.index != _tabController.index) {
            _tabController.animateTo(state.index);
          }
          if (state.createDraftCarSuccess) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return PopScope(
            canPop: canPop,
            onPopInvoked: (bool? i) {
              if (i != null && !i) {
                showDraftDialog(
                    context, state.createCarReq, state.postId != null);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: colors.white,
                  surfaceTintColor: colors.white,
                  leading: IconButton(
                    onPressed: () {
                      if (_tabController.index == 0) {
                        showDraftDialog(
                            context, state.createCarReq, state.postId != null);
                      } else {
                        changeTap(state.createCarReq, _tabController.index - 1);
                      }
                    },
                    icon: Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: icons.back.svg(height: 18),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {
                            showDraftDialog(context, state.createCarReq,
                                state.postId != null);
                          },
                          child: Text(
                            'close'.tr(),
                            textAlign: TextAlign.left,
                            style: fonts.subtitle1,
                          )),
                    )
                  ],
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(30.h),
                      child: _tabBar(colors, (int index) {
                        changeTap(state.createCarReq, index);
                      }))),
              backgroundColor: colors.white,
              body: IndexedStack(
                index: _tabController.index,
                children: const [
                  BrandSelectWidget(),
                  ModelSelectWidget(),
                  PositionSelectWidget(),
                  ModificationSelectWidget(),
                  YearOfManufactureSelectWidget(),
                  BodyTypeSelectWidget(),
                  OptionAddCarWidget(),
                  BasicInformationWidget(),
                  ReplacedPartsWidget(),
                  PriceWidget(),
                  PhotoWidget(),
                  DescriptionWidget(),
                  ContactInfoWidget()
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _tabBar(CustomColorSet colors, ValueChanged<int>? onTap) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      onTap: onTap,
      indicatorColor: colors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: colors.customGreyC3,
      tabAlignment: TabAlignment.center,
      unselectedLabelColor: colors.customGreyC3,
      unselectedLabelStyle: TextStyle(color: colors.customGreyC3),
      tabs: listAddCarTabbar.map((e) {
        return Tab(
          child: Text(
            e,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Style.semiBold14(
                size: 12.sp,
                color: _tabController.index == listAddCarTabbar.indexOf(e)
                    ? colors.primary
                    : colors.customGreyC3),
          ),
        );
      }).toList(),
    );
  }
}
