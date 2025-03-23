import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/data/models/regions_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/district/district_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/region/region_bloc.dart';
import 'package:mpd_client/features/authentication/domain/inherited/open_close_notifier.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/district_category.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/my_custom_exptile.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/themes/styles.dart';

class RegionCategory extends StatefulWidget {
  final List<Region> _regions;

  const RegionCategory({
    super.key,
    required List<Region> regions,
  }) : _regions = regions;

  @override
  State<RegionCategory> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<RegionCategory>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: widget._regions.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 6.h),
        itemBuilder: (context, index) {
          final expansionTileKey = GlobalKey();
          if (index >= widget._regions.length) {
            return Center(
              child: Transform.scale(
                  scale: 0.7, child: const CircularProgressIndicator()),
            );
          }
          return widget._regions[index].isParent!
              ? _buildRegionsList(
                  expansionTileKey, widget._regions[index], index)
              : Material(
                  color: context.color.white,
                  child: Theme(
                    data: ThemeData(
                        highlightColor:
                            context.color.mainBlue.withValues(alpha: 0.1)),
                    child: ListTile(
                        onTap: () {
                          context.read<RegionBloc>().add(SelectRegionEvent(
                              selectedRegion: widget._regions[index]));
                          Navigator.pop(context);
                        },
                        title: Text(
                          widget._regions[index].name,
                          style: Styles.expTitle
                              .copyWith(color: context.color.black),
                        )),
                  ),
                );
        });
  }

  Widget _buildRegionsList(GlobalKey<State<StatefulWidget>> expansionTileKey,
      Region region, int index) {
    return MyExpTile(
        key: expansionTileKey,
        initiallyExpanded: OpenCloseExpansionInheritedNotifier.of(context)
                .notifier!
                .selectedTile ==
            index,
        onExpansionChanged: (value) async {
          if (value) {
            Future.delayed(const Duration(milliseconds: 200)).then((value) {
              context
                  .read<DistrictBloc>()
                  .add(GetDistrictsEvent(parent: region.id));
              OpenCloseExpansionInheritedNotifier.of(context)
                  .notifier!
                  .selectTile = index;
            });
          } else {
            OpenCloseExpansionInheritedNotifier.of(context)
                .notifier!
                .selectTile = -1;
          }
        },
        collapsedIconColor: context.color.black,
        iconColor: context.color.black,
        title: Text(
          region.name,
          style: Styles.expTitle.copyWith(color: context.color.black),
        ),
        children: [
          BlocBuilder<DistrictBloc, DistrictState>(
            builder: (context, state) {
              if (state.districts.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: const LoadingPlatform(),
                  ),
                );
              }
              return DistrictCategory(
                  scrollController: ScrollController(),
                  districts: state.districts,
                  isEmpty: state.isEnd,
                  onScrollEndBloc: () {
                    context
                        .read<DistrictBloc>()
                        .add(GetDistrictsEvent(parent: region.id));
                  });
            },
          )
        ]);
  }

  @override
  bool get wantKeepAlive => true;
}
