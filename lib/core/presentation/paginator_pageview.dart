import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

class PaginatorPageview extends StatelessWidget {
  final FormzSubmissionStatus paginatorStatus;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final VoidCallback fetchMoreFunction;
  final bool hasMoreToFetch;
  final Widget? errorWidget;
  final EdgeInsets? padding;
  final Widget? loadingWidget;
  final ScrollPhysics? physics;
  final PageController? controller;
  final Axis? scrollDirection;

  const PaginatorPageview({
    required this.paginatorStatus,
    required this.itemBuilder,
    required this.itemCount,
    required this.fetchMoreFunction,
    required this.hasMoreToFetch,
    this.errorWidget,
    this.padding = EdgeInsets.zero,
    this.loadingWidget,
    this.physics,
    super.key,
    this.controller,
    this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (paginatorStatus == FormzSubmissionStatus.inProgress) {
      return loadingWidget ?? const Center(child: CupertinoActivityIndicator());
    } else if (paginatorStatus == FormzSubmissionStatus.failure) {
      return errorWidget ?? const SizedBox();
    } else {
      return PageView.builder(
        physics: physics,
        controller: controller,
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemBuilder: (context, index) {
          if (index == itemCount) {
            if (hasMoreToFetch) {
              fetchMoreFunction();
              return loadingWidget ??
                  const Center(child: CupertinoActivityIndicator());
            } else {
              return const SizedBox();
            }
          }
          return itemBuilder(context, index);
        },
        itemCount: itemCount + (hasMoreToFetch ? 1 : 0),
      );
    }
  }
}
