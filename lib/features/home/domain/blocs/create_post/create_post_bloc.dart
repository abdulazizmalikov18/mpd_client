import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mime/mime.dart';
import 'package:mpd_client/core/utils/log_service.dart';
import 'package:mpd_client/core/utils/media_compresser.dart';
import 'package:mpd_client/core/utils/utils.dart';
import 'package:mpd_client/features/home/data/models/file_model.dart';
import 'package:mpd_client/features/home/data/models/upload_post_model.dart';
import 'package:mpd_client/features/home/data/repositories/home_repository.dart';
import 'package:mpd_client/features/home/domain/musur.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(this._descriptionController, this._homeRepository)
    : super(const CreatePostInitial([])) {
    on<SelectImagesAndVideosEvent>(_onSelectImages);

    on<RemoveImageEvent>(_onRemoveImage);
    on<CreatePostPressed>(_onCreatePostPressed);
  }
  final HomeRepository _homeRepository;
  final List<FileModel> _fileImagesAndVideos = [];

  final TextEditingController _descriptionController;

  TextEditingController get descriptionController => _descriptionController;

  Future<void> _onSelectImages(
    SelectImagesAndVideosEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    try {
      if (Platform.isIOS) {
        // iOS uchun eski FilePicket ishlatamiz
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.media,
          allowMultiple: true,
        );
        if (result == null) return;

        for (var path in result.paths) {
          _fileImagesAndVideos.add(
            FileModel(
              file: File(path!),
              fileType: lookupMimeType(path)!.split('/').first,
            ),
          );
        }
      } else {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          event.context,
          pickerConfig: const AssetPickerConfig(
            maxAssets: 9,
            requestType: RequestType.common,
            textDelegate: UzbekAssetPickerTextDelegate(),
          ),
        );

        if (result == null) return;

        for (var asset in result) {
          final File? file = await asset.file;
          if (file != null) {
            String fileType = asset.type == AssetType.image ? 'image' : 'video';
            _fileImagesAndVideos.add(FileModel(file: file, fileType: fileType));
          }
        }
      }

      emit(CreatePostInitial(_fileImagesAndVideos));
    } on PlatformException catch (e) {
      emit(CreatePostFailure(state.files, failure: e.message!));
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<CreatePostState> emit) {
    final images = state.files;
    images.remove(event.file);
    emit(CreatePostInitial(images));
  }

  Future<void> _onCreatePostPressed(
    CreatePostPressed event,
    Emitter<CreatePostState> emit,
  ) async {
    // ? Validate image has or not
    if (_fileImagesAndVideos.isEmpty) {
      return emit(CreatePostInitial(state.files, isValidImage: false));
    }

    emit(CreatePostLoading(state.files, isValidImage: state.isValidImage));
    final List<MultipartFile> postImages = [];
    final List<MultipartFile> postVideos = [];
    final List<MultipartFile> postVideosScreenshot = [];

    for (var file in _fileImagesAndVideos) {
      if (file.fileType == 'image') {
        final compressedImage = await MediaCompresser.compressAndTryCatchImage(
          file.file.path,
        );

        postImages.add(
          MultipartFile.fromBytes(
            compressedImage,
            filename: basename(file.file.path),
          ),
        );
        for (var element in postImages) {
          Log.e(element.filename);
        }
      } else if (file.fileType == 'video') {
        final mimeType = lookupMimeType(file.file.path) ?? 'video/mp4';
        final mediaType = MediaType.parse(mimeType);

        final uint8list = await VideoCompress.getByteThumbnail(
          file.file.path,
          position: -1,
          quality: 75,
        );
        final noCompressed = await file.file.readAsBytes();

        postVideosScreenshot.add(
          MultipartFile.fromBytes(
            uint8list!,
            filename: 'thumbnail_${basename(file.file.path)}.jpg',
          ),
        );

        postVideos.add(
          MultipartFile.fromBytes(
            noCompressed,
            filename: basename(file.file.path),
            contentType: mediaType,
          ),
        );
      }
    }

    final result = await _homeRepository.createPost(
      UploadPost(
        text: descriptionController.text,
        images: postImages,
        screenshots: postVideosScreenshot,
        // aspectRatio: '4x3',
        files: postVideos,
      ),
    );

    if (result.isRight) {
      emit(
        CreatePostSucces(
          state.files,
          createdPost: result.right,
          isValidImage: state.isValidImage,
        ),
      );
    } else {
      emit(
        CreatePostFailure(
          state.files,
          failure: Utils.errorFormat(result.left.message),
          isValidImage: state.isValidImage,
        ),
      );
    }
  }
}
