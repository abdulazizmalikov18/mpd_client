import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/bloc/profession_bloc.dart';
import 'package:mpd_client/features/authentication/domain/blocs/sub_profession/sub_professions_bloc.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/my_custom_exptile.dart';
import 'package:mpd_client/features/authentication/presentation/pages/register_detail/informations/components/profession_subcategory.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ProfessionCategory extends StatefulWidget {
  final ScrollController _scrollController;
  final List<Profession> _professions;
  final bool isEnd;
  final VoidCallback onScrollEndBloc;

  const ProfessionCategory(
      {super.key,
      required ScrollController scrollController,
      required List<Profession> professions,
      required this.isEnd,
      required this.onScrollEndBloc})
      : _scrollController = scrollController,
        _professions = professions;

  @override
  State<ProfessionCategory> createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ProfessionCategory>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        controller: widget._scrollController,
        itemCount: widget.isEnd
            ? widget._professions.length
            : widget._professions.length + 1,
        padding: EdgeInsets.only(top: 12.h),
        itemBuilder: (context, index) {
          final expansionTileKey = GlobalKey();

          if (index >= widget._professions.length) {
            return const Center(child: LoadingPlatform());
          }

          return widget._professions[index].isParent!
              ? _buildProfessionsList(
                  expansionTileKey, widget._professions[index])
              : Material(
                  color: context.color.white,
                  child: Theme(
                    data: ThemeData(
                        highlightColor:
                            context.color.mainBlue.withValues(alpha: 0.1)),
                    child: ListTile(
                      onTap: () {
                        context.read<ProfessionBloc>().add(
                            ChooseProfessionEvent(widget._professions[index]));
                        Navigator.pop(context);
                      },
                      title: Text(
                        widget._professions[index].name!,
                        style: Styles.expTitle
                            .copyWith(color: context.color.black),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        widget._scrollController.position.extentAfter == 0) {
      widget.onScrollEndBloc();
    }
    return false;
  }

  MyExpTile _buildProfessionsList(
      GlobalKey<State<StatefulWidget>> expansionTileKey,
      Profession profession) {
    return MyExpTile(
        key: expansionTileKey,
        initiallyExpanded: false,
        onExpansionChanged: (value) {
          _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          if (value) {
            context
                .read<SubProfessionsBloc>()
                .add(GetSubProfessionsEvent(parent: profession.id!));
          }
        },
        collapsedIconColor: context.color.black,
        iconColor: context.color.black,
        title: Text(
          profession.name!,
          style: Styles.expTitle.copyWith(color: context.color.black),
        ),
        children: [
          SizedBox(
            height: 500.h,
            child: BlocBuilder<SubProfessionsBloc, SubProfessionsState>(
              builder: (context, state) {
                if (state.subProfessions.isEmpty) {
                  return const Center(child: LoadingPlatform());
                }
                return ProfessionSubCategory(
                    scrollController: ScrollController(),
                    professions: state.subProfessions,
                    isEmpty: state.isEnd,
                    onScrollEndBloc: () {
                      context
                          .read<SubProfessionsBloc>()
                          .add(GetSubProfessionsEvent(parent: profession.id!));
                    });
              },
            ),
          )
        ]);
  }

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        if (keyContext.mounted) {
          Scrollable.ensureVisible(
            keyContext,
            duration: const Duration(milliseconds: 200),
          );
        }
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
