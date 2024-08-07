import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/application/post/post_bloc.dart';
import 'package:mpd_client/domain/entity/lenta/create_post_param.dart';
import 'package:mpd_client/presentation/pages/lenta/widgets/w_post_add_media_item.dart';
import 'package:mpd_client/presentation/styles/colors.dart';
import 'package:mpd_client/presentation/styles/theme.dart';
import 'package:mpd_client/presentation/widgets/w_app_bar.dart';
import 'package:mpd_client/presentation/widgets/w_button.dart';
import 'package:mpd_client/presentation/widgets/w_text_field.dart';

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
        
        back: true,
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
              const WPostAddPhotoItem(),
              const SizedBox(height: 16),
              const Text(
                'Share your thoughts',
                style: AppTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              WTextField(
                onChanged: (_) {},
                maxLines: 4,
                controller: descriptionController,
                height: 88,
                hintText: 'Write your description',
                fillColor: white.withOpacity(0.1),
                borderColor: border,
                style: AppTheme.labelLarge.copyWith(
                  color: black,
                ),
                hintStyle: AppTheme.labelLarge.copyWith(
                  color: black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return WButton(
            onTap: onPressCreate,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            isLoading: state.status.isInProgress,
            text: 'Publish',
            textStyle: AppTheme.headlineSmall.copyWith(
              color: white,
            ),
          );
        },
      ),
    );
  }
}
