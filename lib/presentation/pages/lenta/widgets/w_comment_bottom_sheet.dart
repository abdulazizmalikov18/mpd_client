import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpd_client/presentation/pages/lenta/view/comment_view.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';

class WCommentBottomSheet extends StatelessWidget {
  const WCommentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final parentWidget = CommentView.maybeOf(context)!;
    return BottomSheet(
      shape: const RoundedRectangleBorder(),
      backgroundColor: Colors.white,
      elevation: 0,
      onClosing: () {},
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 8),
                child: WTextField(
                  controller: parentWidget.controller,
                  focusNode: parentWidget.focusNode,
                  onChanged: (e) {},
                  style: AppTheme.labelSmall.copyWith(
                    color: mainColor,
                  ),
                  onEditingComplete: parentWidget.sendComment,
                  fillColor: scaffoldSecondaryBackground,
                  borderColor: Colors.transparent,
                  height: 40,
                  hintText: 'Fikringizni yozib qoldiring !',
                  hintStyle: AppTheme.labelSmall.copyWith(
                    color: gray,
                  ),
                  prefixIcon: const Icon(
                    CupertinoIcons.smiley,
                    color: gray,
                  ),
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: parentWidget.isLoading,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: value
                            ? CircularProgressIndicator.adaptive(
                                strokeWidth: 1,
                                valueColor: Animation<Color>.fromValueListenable(ValueNotifier(gray)),
                              )
                            : InkWell(
                                onTap: parentWidget.sendComment,
                                child: const Icon(Icons.send),
                              ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
