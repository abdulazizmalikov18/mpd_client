import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/presentation/component/app_bar_component.dart';
import 'package:orient_motors/presentation/pages/search/pages/filter_sets/component/info_list_item.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';

class ServiceInfoPage extends StatefulWidget {
  const ServiceInfoPage({
    super.key,
  });

  @override
  State<ServiceInfoPage> createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState extends State<ServiceInfoPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          final service = state.servicesList;
          return Scaffold(
            backgroundColor: colors.white,
            appBar: const AppBarComponent(
              title: "",
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: service?.length ?? 0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        itemBuilder: (context, index) {
                          return InfoListItem(
                            colors: colors,
                            fonts: fonts,
                            title: service?[index].title ?? "",
                            subtitle: service?[index].description ?? "",
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: colors.customGreyC3.withOpacity(0.3),
                            height: 31.h,
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
