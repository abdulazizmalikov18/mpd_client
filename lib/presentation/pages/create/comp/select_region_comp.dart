import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/component/custom_text_field_with_icon.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class SelectRegionComp extends StatefulWidget {
  final List<NamedModel> regions;
  final int? regionId;
  final GlobalKey<FormState> formKey;
  final Function(NamedModel) onRegionSelected;

  const SelectRegionComp(
      {super.key,
      required this.regions,
      required this.onRegionSelected,
      required this.formKey,
      this.regionId});

  @override
  State<SelectRegionComp> createState() => _SelectRegionCompState();
}

class _SelectRegionCompState extends State<SelectRegionComp> {
  late TextEditingController _controller;

  @override
  void initState() {
    int index = widget.regions
        .lastIndexWhere((element) => element.id == widget.regionId);
    NamedModel? region = index == -1 ? null : widget.regions[index];
    _controller = TextEditingController(text: region?.name);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'choose_region'.tr(),
            textAlign: TextAlign.center,
            style: fonts.subtitle2.copyWith(fontSize: 14.sp),
          ),
          8.verticalSpace,
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: widget.formKey,
            child: CustomTextFieldWithIcon(
              onTap: () {
                showDialog(
                        context: context,
                        builder: (_) =>
                            SelectRegionDialog(regions: widget.regions))
                    .then((value) {
                  if (value != null && value is NamedModel) {
                    _controller.text = value.name ?? "";
                    widget.onRegionSelected(value);
                  }
                });
              },
              keyboardType: TextInputType.phone,
              hasSuffixIcon: true,
              readOnly: true,
              onChanged: (value) {},
              controller: _controller,
              icons: icons.locationHome,
              colors: colors,
              hintText: 'region'.tr(),
              validator: (String? text) {
                if (text != null && text.isEmpty) {
                  return "choose_region".tr();
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      );
    });
  }
}

class SelectRegionDialog extends StatelessWidget {
  final List<NamedModel> regions;

  const SelectRegionDialog({super.key, required this.regions});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (ctx, colors, fonts, icons, controller) {
      return Dialog(
        backgroundColor: colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Divider(
                  color: colors.customGreyC3,
                  height: 1,
                ),
              );
            },
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).pop(regions[index]);
                },
                title: Text(
                  regions[index].name ?? "",
                  style: fonts.subtitle1,
                ),
              );
            },
            itemCount: regions.length),
      );
    });
  }
}
