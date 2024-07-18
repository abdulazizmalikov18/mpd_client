import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/application/auth/controller/registration_view_model.dart';
import 'package:mpd_client/domain/entity/account/region_entity.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/widgets/w_scale_animation.dart';

class RegionListView extends StatefulWidget {
  const RegionListView({
    super.key,
    required this.regions,
    required this.controller,
    required this.index,
    required this.isLoading,
  });

  final List<RegionEntity> regions;
  final PageController controller;
  final int index;
  final bool isLoading;

  @override
  State<RegionListView> createState() => _RegionListViewState();
}

class _RegionListViewState extends State<RegionListView> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.regions.length,
            itemBuilder: (context, index) => WScaleAnimation(
              onTap: () {
                if (widget.regions[index].isParent) {
                  if (widget.controller.hasClients) {
                    widget.controller.animateToPage(
                      widget.index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                  $regVM().selectPag(
                    context,
                    widget.index,
                    widget.regions[index].name,
                    widget.regions[index].id,
                  );
                } else {
                  Navigator.pop(context, MapEntry(widget.regions[index].id, widget.regions[index].name));
                  $regVM().selectPag(context, 0, "", 0);
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.regions[index].name),
                    if (widget.regions[index].isParent)
                      const Icon(
                        CupertinoIcons.right_chevron,
                        color: gray,
                      )
                    else
                      const SizedBox()//AppIcons.icHome.svg(),
                  ],
                ),
              ),
            ),
          );
  }
}
