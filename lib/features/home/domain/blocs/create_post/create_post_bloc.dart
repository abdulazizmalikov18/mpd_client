import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
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
    // 1. Rasmlar borligini tekshirish
    if (_fileImagesAndVideos.isEmpty) {
      return emit(CreatePostInitial(state.files, isValidImage: false));
    }

    emit(CreatePostLoading(state.files, isValidImage: state.isValidImage));

    final List<MultipartFile> postImages = [];
    final List<MultipartFile> postVideos = [];
    final List<MultipartFile> postVideosScreenshot = [];

    // 2. Qurilma turini aniqlash (Simulator vs Real Device)
    final deviceInfo = DeviceInfoPlugin();
    bool isSimulator = false;

    if (Platform.isIOS) {
      try {
        final iosInfo = await deviceInfo.iosInfo;
        isSimulator = !iosInfo.isPhysicalDevice;
      } catch (e) {
        Log.e("Device info olishda xatolik: $e");
      }
    }

    try {
      for (var file in _fileImagesAndVideos) {
        // ----------------- Rasm Logikasi -----------------
        if (file.fileType == 'image') {
          List<int>? finalImageBytes;
          String fileName;
          MediaType contentType;

          if (isSimulator) {
            // A) SIMULYATOR: Crash bermasligi uchun siqishni o'tkazib yuboramiz
            Log.w("Simulyator aniqlandi: Rasm siqilmadi.");
            finalImageBytes = await file.file.readAsBytes();

            // Server 400 xato bermasligi uchun nomini va tipini JPG qilamiz
            // (Aslida HEIC bo'lsa ham, serverni aldash uchun)
            String nameWithoutExt = basenameWithoutExtension(file.file.path);
            fileName = "$nameWithoutExt.jpg";
            contentType = MediaType('image', 'jpeg');
          } else {
            // B) REAL QURILMA: Rasmni siqamiz (Compress)
            try {
              final result = await MediaCompresser.compressAndTryCatchImage(
                file.file.path,
              );

              if (result.isNotEmpty) {
                finalImageBytes = result;
              } else {
                // Agar compress o'xshamasa originalni olamiz
                finalImageBytes = await file.file.readAsBytes();
              }
            } catch (e) {
              Log.e("Compress error: $e");
              finalImageBytes = await file.file.readAsBytes();
            }

            // Real fayl nomini va tipini olamiz
            fileName = basename(file.file.path);
            final mimeType = lookupMimeType(file.file.path) ?? 'image/jpeg';
            contentType = MediaType.parse(mimeType);
          }

          // Fayl baytlari bo'lsa ro'yxatga qo'shamiz
          postImages.add(
            MultipartFile.fromBytes(
              finalImageBytes,
              filename: fileName,
              contentType: contentType,
            ),
          );
        }
        // ----------------- Video Logikasi -----------------
        else if (file.fileType == 'video') {
          final mimeType = lookupMimeType(file.file.path) ?? 'video/mp4';
          final mediaType = MediaType.parse(mimeType);

          // Thumbnail yaratish
          final uint8list = await VideoCompress.getByteThumbnail(
            file.file.path,
            position: -1,
            quality: 75,
          );

          if (uint8list != null) {
            postVideosScreenshot.add(
              MultipartFile.fromBytes(
                uint8list,
                filename: 'thumbnail_${basename(file.file.path)}.jpg',
                contentType: MediaType('image', 'jpeg'),
              ),
            );
          }

          // Videoni o'zini o'qish
          final noCompressed = await file.file.readAsBytes();
          postVideos.add(
            MultipartFile.fromBytes(
              noCompressed,
              filename: basename(file.file.path),
              contentType: mediaType,
            ),
          );
        }
      }

      // 3. API ga yuborish
      final result = await _homeRepository.createPost(
        UploadPost(
          text: descriptionController.text,
          images: postImages,
          screenshots: postVideosScreenshot,
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
    } catch (e) {
      Log.e("Global xatolik CreatePostBloc: $e");
      emit(
        CreatePostFailure(
          state.files,
          failure: "Noma'lum xatolik yuz berdi: $e",
          isValidImage: state.isValidImage,
        ),
      );
    }
  }
}
