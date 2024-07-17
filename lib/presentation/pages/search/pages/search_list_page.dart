import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:orient_motors/application/search/search_bloc.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/presentation/component/custom_text_field.dart';
import 'package:orient_motors/presentation/component/un_focus_widget.dart';
import 'package:orient_motors/presentation/pages/home/favorites/widget/recently_search_widget.dart';
import 'package:orient_motors/presentation/routes/routes.dart';
import 'package:orient_motors/presentation/styles/style.dart';
import 'package:orient_motors/presentation/styles/theme.dart';
import 'package:orient_motors/presentation/styles/theme_wrapper.dart';
import 'package:orient_motors/utils/debounce.dart';

class SearchListPage extends StatefulWidget {
  const SearchListPage({super.key});

  @override
  State<SearchListPage> createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        return OnUnFocusTap(
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 8.w,
              surfaceTintColor: colors.white,
              title: CustomTextField(
                hintText: "ex: Cobalt",
                padding: EdgeInsets.only(top: 4.h, right: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: colors.transparent, width: 0.8),
                ),
                enableBorderColor: colors.primary,
                fillColor: colors.searchTextfieldColor,
                onChanged: (value) {
                  onDebounce(() {
                    context.read<SearchBloc>().add(
                        SearchEvent.getSearchesGenerationList(
                            name: value.trim()));
                  });
                  isSearching = value.isNotEmpty;
                },
              ),
            ),
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (!isSearching) {
                  return const RecentlySearchWidget();
                }

                if (state.searchList.isEmpty) {
                  return Center(
                    child: Text(
                      "no_more_data".tr(),
                      style: Style.bold16(),
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final item = state.searchList[index];
                    return ListTile(
                      onTap: () {
                        final param = FilterSearchReq(
                          (build) => build
                            ..generation = ListBuilder([item.id])
                            ..brand = item.brandId
                            ..carModel = item.carModelId,
                        );

                        context
                            .read<SearchBloc>()
                            .add(SearchEvent.searchSave(request: param));

                        Navigator.push(
                                context,
                                AppRoutes.goToResult(context,
                                    generation: item.id))
                            .then((value) => context
                                .read<BottomNavBarController>()
                                .changeNavBar(true));
                      },
                      title: Text("${item.brand} ${item.carModel}"),
                      subtitle: Row(
                        children: [
                          Expanded(child: Text("${item.name}")),
                          Text(
                              "${item.yearStart ?? ""} - ${item.yearStop ?? "now".tr()}"),
                        ],
                      ),
                    );
                  },
                  itemCount: state.searchList.length,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
