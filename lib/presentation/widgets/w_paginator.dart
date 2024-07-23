
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';

class PaginatorList extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget? errorWidget;
  final EdgeInsets? padding;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Axis scrollDirection;
  final Widget? loadingWidget;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool reverse;

  const PaginatorList({
    required this.paginatorStatus,
    required this.itemBuilder,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    this.errorWidget,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.separatorBuilder,
    this.loadingWidget,
    this.physics,
    this.controller,
    super.key,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.inProgress) {
      return loadingWidget ??
          Center(
              child: Lottie.asset(
            'assets/anim/loading_light.json',
            height: 32,
            width: 32,
          ));
    } else if (paginatorStatus == FormzSubmissionStatus.failure) {
      return errorWidget ?? const SizedBox();
    } else {
      return ListView.separated(
        scrollDirection: scrollDirection,
        physics: physics ?? const BouncingScrollPhysics(),
        padding: padding,
        controller: controller,
        shrinkWrap: true,
        reverse: reverse,
        itemBuilder: (context, index) {
          if (index == itemCount) {
            if (hasMoreToFetch) {
              fetchMoreFunction();
              return Center(
                child: const CupertinoActivityIndicator(),
              );
            } else {
              return const SizedBox();
            }
          }
          return itemBuilder(context, index);
        },
        separatorBuilder: separatorBuilder ?? (context, index) => const SizedBox(),
        itemCount: itemCount + 1,
      );
    }
  }
}
