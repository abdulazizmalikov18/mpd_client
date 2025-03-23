import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mpd_client/app/app_colors.dart';
import 'package:mpd_client/features/authentication/data/models/profession_model.dart';
import 'package:mpd_client/features/authentication/domain/blocs/sub_profession/sub_professions_bloc.dart';
import 'package:mpd_client/src/loading/loading_platform.dart';
import 'package:mpd_client/src/themes/styles.dart';

class ProfessionSubCategory extends StatelessWidget {
  final ScrollController _scrollController;
  final List<Profession> _professions;
  final VoidCallback onScrollEndBloc;
  final bool isEmpty;
  const ProfessionSubCategory(
      {super.key,
      required ScrollController scrollController,
      required List<Profession> professions,
      required this.isEmpty,
      required this.onScrollEndBloc})
      : _scrollController = scrollController,
        _professions = professions;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _professions.length + 1,
        shrinkWrap: true,
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index >= _professions.length) {
            if (isEmpty) {
              return const SizedBox();
            }
            return const Center(child: LoadingPlatform());
          }
          return Material(
            color: context.color.white,
            child: Theme(
              data: ThemeData(
                  highlightColor:
                      context.color.mainBlue.withValues(alpha: 0.1)),
              child: ListTile(
                  onTap: () {
                    // context.read<ProfessionsBloc>().add(
                    //     const SelectProfessionEvent(selectedProfessin: null));
                    context.read<SubProfessionsBloc>().add(
                        SelectSubProfessionEvent(
                            selectedSubProfession: _professions[index]));
                    Navigator.pop(context);
                  },
                  contentPadding: EdgeInsets.only(left: 32.w),
                  title: Text(
                    _professions[index].name!,
                    style: Styles.descSubtitle
                        .copyWith(color: context.color.black),
                  )),
            ),
          );
        },
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      onScrollEndBloc();
    }
    return false;
  }
}
