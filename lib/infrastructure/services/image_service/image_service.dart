import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orient_motors/presentation/component/easy_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as im;
import 'package:image_cropper/image_cropper.dart';
import 'package:orient_motors/infrastructure/services/image_service/camera_picker/wechat_camera_picker.dart';
import 'package:orient_motors/infrastructure/services/image_service/image_picker/wechat_assets_picker.dart';
import 'package:path/path.dart' as ph;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../presentation/styles/style.dart';
import '../../../presentation/styles/theme.dart';
import '../../../presentation/styles/theme_wrapper.dart';

class ImageService {
  static Future<String?> compressImage(File imageFile) async {
    // final fileName = ph.basename(imageFile.path);
    var uuid = const Uuid();
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image? image = im.decodeImage(imageFile.readAsBytesSync());
    if (image == null) {
      return null;
    } else {
      im.Image smallerImage = im.copyResize(image, height: 512);
      var compressedImage = File('$path/i${uuid.v4()}.jpg')
        ..writeAsBytesSync(im.encodeJpg(smallerImage, quality: 90));
      return compressedImage.path;
    }
  }

  static Future<String?> imageCrop(
    String path, {
    CropStyle? cropStyle,
    List<CropAspectRatioPreset>? aspectRatioPresets,
  }) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: cropStyle ?? CropStyle.rectangle,
        aspectRatio: aspectRatioPresets != null
            ? aspectRatioPresets.contains(CropAspectRatioPreset.square)
                ? const CropAspectRatio(ratioX: 1, ratioY: 1)
                : aspectRatioPresets.contains(CropAspectRatioPreset.ratio16x9)
                    ? const CropAspectRatio(ratioX: 16, ratioY: 9)
                    : null
            : null,
        aspectRatioPresets: aspectRatioPresets ??
            [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Style.primary,
              toolbarWidgetColor: Style.white,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: true),
          IOSUiSettings(
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockEnabled: true,
            minimumAspectRatio: 1.0,
          )
        ],
      );
      if (croppedFile != null) {
        return croppedFile.path;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<AssetEntity>?> showPicker(BuildContext context,
      {CropStyle? cropStyle,
      List<CropAspectRatioPreset>? aspectRatioPresets,
      bool crop = true,
      int maxAssets = 1,
      List<AssetEntity>? selectedAssets}) async {
    BottomNavBarController globalController =
        context.read<BottomNavBarController>();
    bool isOpen = globalController.hiddenNavBar;
    globalController.changeNavBar(true);
    List<AssetEntity>? assets = await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ThemeWrapper(builder: (BuildContext context,
              CustomColorSet colors, FontSet fonts, IconSet icons, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library, color: colors.secondary),
                    title: Text(
                      'gallery'.tr(),
                      style: fonts.subtitle1
                          .copyWith(fontSize: 15.sp, color: colors.secondary),
                    ),
                    onTap: () async {
                      List<AssetEntity>? asset = await _imgFromGallery(
                          context, colors,
                          cropStyle: cropStyle,
                          aspectRatioPresets: aspectRatioPresets,
                          crop: crop,
                          maxAssets: maxAssets,
                          selectedAssets: selectedAssets);
                      if (asset != null && asset.isNotEmpty) {
                        Navigator.of(context).pop(asset);
                      } else {
                        Navigator.of(context).pop(<AssetEntity>[]);
                      }
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: colors.secondary),
                  title: Text(
                    'camera'.tr(),
                    style: fonts.subtitle1
                        .copyWith(fontSize: 15.sp, color: colors.secondary),
                  ),
                  onTap: () async {
                    AssetEntity? asset = await _imgFromCamera(context,
                        cropStyle: cropStyle,
                        aspectRatioPresets: aspectRatioPresets,
                        crop: crop);
                    if (asset != null) {
                      Navigator.of(context).pop([asset]);
                    } else {
                      Navigator.of(context).pop(<AssetEntity>[]);
                    }
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            );
          });
        });
    globalController.changeNavBar(isOpen);
    return assets;
  }

  static Future<AssetEntity?> _imgFromCamera(BuildContext context,
      {CropStyle? cropStyle,
      List<CropAspectRatioPreset>? aspectRatioPresets,
      bool crop = true}) async {
    try {
      AssetEntity? assets = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: const CameraPickerConfig(
          textDelegate: EnglishCameraPickerTextDelegate(),
        ),
      );
      if (assets != null) {
        if (crop) {
          File? file = await assets.file;
          if (file != null) {
            String? path = await imageCrop(file.path,
                cropStyle: cropStyle, aspectRatioPresets: aspectRatioPresets);
            if (path != null) {
              final AssetEntity? fileEntity =
                  await PhotoManager.editor.saveImageWithPath(
                path,
                title: ph.basename(path),
              );
              if (fileEntity != null) {
                return fileEntity;
              } else {
                return null;
              }
            } else {
              return null;
            }
          } else {
            return null;
          }
        } else {
          return assets;
        }
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('${"image_upload_error".tr()} $e');
      return null;
    }
  }

  static Future<List<AssetEntity>?> _imgFromGallery(
      BuildContext context, CustomColorSet colors,
      {CropStyle? cropStyle,
      List<CropAspectRatioPreset>? aspectRatioPresets,
      bool crop = true,
      required int maxAssets,
      List<AssetEntity>? selectedAssets}) async {
    try {
      List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          themeColor: colors.primary,
          selectedAssets: selectedAssets,
          maxAssets: maxAssets,
          textDelegate: const EnglishAssetPickerTextDelegate(),
          requestType: RequestType.image,
        ),
      );
      if (assets != null && assets.isNotEmpty) {
        if (crop) {
          List<AssetEntity> assetsCrop = [];
          await Future.forEach(assets, (AssetEntity? element) async {
            if (element != null) {
              if (selectedAssets != null
                  ? !selectedAssets.contains(element)
                  : true) {
                File? file = await element.file;
                if (file != null) {
                  String? path = await imageCrop(file.path,
                      aspectRatioPresets: aspectRatioPresets,
                      cropStyle: cropStyle);
                  if (path != null) {
                    final AssetEntity? fileEntity =
                        await PhotoManager.editor.saveImageWithPath(
                      path,
                      title: ph.basename(path),
                    );
                    if (fileEntity != null) {
                      assetsCrop.add(fileEntity);
                    }
                  }
                }
              } else {
                assetsCrop.add(element);
              }
            }
          });
          if (assetsCrop.isNotEmpty) {
            return assetsCrop;
          } else {
            return null;
          }
        } else {
          return assets;
        }
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('${"image_upload_error".tr()} $e');
      return null;
    }
  }
}
