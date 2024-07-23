import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_bottom_sheet.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_post_add_media_item.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_user_detail.dart';
import 'package:mpd_client/presentation/styles/app_icons.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';
import 'package:mpd_client/utils/extensions/string_ext.dart';

part '../mixin/create_post_mixin.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();

  static _CreatePostViewState? maybeOf(BuildContext context) => context.findAncestorStateOfType<_CreatePostViewState>();
}

class _CreatePostViewState extends State<CreatePostView> with CreatePostMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const WAppBar(
          title: Text('Create Post'),
          action: SizedBox(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const WUserDetail(),
                const SizedBox(height: 16),
                const WPostAddPhotoItem(),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: AppTheme.headlineSmall.copyWith(
                      fontSize: 10,
                      color: white.withOpacity(0.5),
                    ),
                    children: [
                      TextSpan(
                        text: 'Sizes: ',
                        style: AppTheme.headlineSmall.copyWith(
                          fontSize: 10,
                          color: orang,
                        ),
                      ),
                      const TextSpan(text: '1080 x 1080 px | 1080 x 1920 px | 1200 x 315 px'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Share your thoughts',
                  style: AppTheme.labelSmall.copyWith(
                    color: white,
                  ),
                ),
                const SizedBox(height: 8),
                WTextField(
                  onChanged: (_) {},
                  maxLines: 4,
                  controller: descriptionController,
                  height: 88,
                  hintText: 'Type...',
                  fillColor: white.withOpacity(0.1),
                  borderColor: borderColor,
                  style: AppTheme.labelLarge.copyWith(
                    color: white,
                  ),
                  hintStyle: AppTheme.labelLarge.copyWith(
                    color: white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return WButtonBottomSheet(
              onTap: onPressCreate,
              isLoading: state.status.isInProgress,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcons.plus.svg(
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Publish',
                    style: AppTheme.headlineSmall.copyWith(
                      color: white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}
