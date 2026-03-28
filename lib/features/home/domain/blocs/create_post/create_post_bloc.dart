import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mime/mime.dart';
import 'package:mpd_client/app/colors.dart';
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
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:permission_handler/permission_handler.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(this._descriptionController, this._homeRepository)
    : super(const CreatePostInitial([])) {
    // ✅ YECHIM 3: droppable() → sequential() ga o'zgartirildi
    on<SelectImagesAndVideosEvent>(_onSelectImages, transformer: sequential());
    on<RemoveImageEvent>(_onRemoveImage);
    on<CreatePostPressed>(_onCreatePostPressed);
  }

  final HomeRepository _homeRepository;
  final List<FileModel> _fileImagesAndVideos = [];
  final TextEditingController _descriptionController;

  TextEditingController get descriptionController => _descriptionController;

  // ✅ YECHIM 1 (helper): Real qurilmami yoki simulyatormi aniqlash
  Future<bool> _isPhysicalDevice() async {
    try {
      if (Platform.isIOS) {
        final info = await DeviceInfoPlugin().iosInfo;
        return info.isPhysicalDevice;
      }
      // Android uchun har doim true (simulyatorda muammo yo'q)
      return true;
    } catch (_) {
      return true; // Xatolikda real qurilma deb hisoblaymiz
    }
  }

  Future<void> _onSelectImages(
    SelectImagesAndVideosEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    try {
      // ✅ YECHIM 1: Faqat real qurilmada permission so'raymiz
      final isPhysical = await _isPhysicalDevice();

      if (isPhysical) {
        final status = await Permission.photos.request();

        if (status.isPermanentlyDenied) {
          return emit(
            CreatePostFailure(
              state.files,
              failure: "Galereyaga ruxsat berilmagan. Sozlamalardan yoqing.",
            ),
          );
        }

        // Rad etilgan bo'lsa shunchaki qaytamiz
        if (!status.isGranted && !status.isLimited) return;
      } else {
        Log.w("Simulyator aniqlandi: Permission so'rovi o'tkazib yuborildi.");
      }

      if (!event.context.mounted) return;

      // Picker ochish
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        event.context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 9,
          requestType: RequestType.common,
          textDelegate: resolveDelegate(event.context),
          pickerTheme: AssetPicker.themeData(mainBlue),
        ),
      );

      if (result == null) return;

      for (var asset in result) {
        final File? file = await asset.file;
        if (file != null) {
          final fileType = asset.type == AssetType.image ? 'image' : 'video';
          _fileImagesAndVideos.add(FileModel(file: file, fileType: fileType));
        }
      }

      emit(CreatePostInitial(_fileImagesAndVideos));
    } on PlatformException catch (e) {
      // ✅ YECHIM 2: multiple_request xatosini jimgina ushlab olamiz
      if (e.code == 'multiple_request') {
        Log.w("Picker allaqachon ochiq, yangi so'rov bekor qilindi.");
        return; // State o'zgarmaydi, foydalanuvchi hech narsa sezmaydi
      }
      emit(
        CreatePostFailure(
          state.files,
          failure: e.message ?? "Rasm tanlashda xatolik yuz berdi.",
        ),
      );
    } catch (e) {
      Log.e("Rasm tanlashda kutilmagan xatolik: $e");
      emit(
        CreatePostFailure(state.files, failure: "Rasm tanlashda xatolik: $e"),
      );
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<CreatePostState> emit) {
    final images = List<FileModel>.from(state.files);
    images.remove(event.file);
    emit(CreatePostInitial(images));
  }

  Future<void> _onCreatePostPressed(
    CreatePostPressed event,
    Emitter<CreatePostState> emit,
  ) async {
    if (_fileImagesAndVideos.isEmpty) {
      return emit(CreatePostInitial(state.files, isValidImage: false));
    }

    emit(CreatePostLoading(state.files, isValidImage: state.isValidImage));

    final List<MultipartFile> postImages = [];
    final List<MultipartFile> postVideos = [];
    final List<MultipartFile> postVideosScreenshot = [];

    // Qurilma turini bir marta aniqlaymiz
    final isPhysical = await _isPhysicalDevice();
    final isSimulator = !isPhysical;

    try {
      for (var file in _fileImagesAndVideos) {
        if (file.fileType == 'image') {
          List<int> finalImageBytes;
          String fileName;
          MediaType contentType;

          if (isSimulator) {
            Log.w("Simulyator: Rasm siqilmadi.");
            finalImageBytes = await file.file.readAsBytes();
            fileName = "${basenameWithoutExtension(file.file.path)}.jpg";
            contentType = MediaType('image', 'jpeg');
          } else {
            try {
              final result = await MediaCompresser.compressAndTryCatchImage(
                file.file.path,
              );
              finalImageBytes = result.isNotEmpty
                  ? result
                  : await file.file.readAsBytes();
            } catch (e) {
              Log.e("Compress error: $e");
              finalImageBytes = await file.file.readAsBytes();
            }
            fileName = basename(file.file.path);
            final mimeType = lookupMimeType(file.file.path) ?? 'image/jpeg';
            contentType = MediaType.parse(mimeType);
          }

          postImages.add(
            MultipartFile.fromBytes(
              finalImageBytes,
              filename: fileName,
              contentType: contentType,
            ),
          );
        } else if (file.fileType == 'video') {
          final mimeType = lookupMimeType(file.file.path) ?? 'video/mp4';
          final mediaType = MediaType.parse(mimeType);

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

          final videoBytes = await file.file.readAsBytes();
          postVideos.add(
            MultipartFile.fromBytes(
              videoBytes,
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
            isActionFailure: true,
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
          isActionFailure: true,
          isValidImage: state.isValidImage,
        ),
      );
    }
  }
}
