// import 'package:flutter/material.dart';
// import 'package:mpd_client/app/app_colors.dart';
// import 'package:mpd_client/l10n/l10n.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// class AssetPickerConfiguration {
//   AssetPickerConfig config(
//       {required List<AssetEntity> assets, required int maxCount}) {
//     const AssetPickerTextDelegate textDelegate = AssetPickerTextDelegate();
//     return AssetPickerConfig(
//       maxAssets: maxCount,
//       selectedAssets: assets,
//       pickerTheme: ThemeData.light(useMaterial3: true)
//           .copyWith(primaryColor: context.color.white),
//       specialItemPosition: SpecialItemPosition.prepend,
//       specialItemBuilder: (
//         BuildContext context,
//         AssetPathEntity? path,
//         int length,
//       ) {
//         if (path?.isAll != true) {
//           return null;
//         }
//         return Semantics(
//           label: textDelegate.sActionUseCameraHint,
//           button: true,
//           onTapHint: textDelegate.sActionUseCameraHint,
//           child: GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () async {
//               final AssetEntity? result = await _pickFromCamera(context);
//               if (result == null) {
//                 return;
//               }
//               final AssetPicker<AssetEntity, AssetPathEntity> picker =
//                   context.findAncestorWidgetOfExactType()!;
//               final DefaultAssetPickerBuilderDelegate builder =
//                   picker.builder as DefaultAssetPickerBuilderDelegate;
//               final DefaultAssetPickerProvider p = builder.provider;
//               await p.switchPath(
//                 PathWrapper<AssetPathEntity>(
//                   path: await p.currentPath!.path.obtainForNewProperties(),
//                 ),
//               );
//               p.selectAsset(result);
//             },
//             child: const Center(
//               child: Icon(Icons.camera, size: 42.0),
//             ),
//           ),
//         );
//       },
//       filterOptions: FilterOptionGroup()
//         ..setOption(
//           AssetType.video,
//           const FilterOption(
//             durationConstraint: DurationConstraint(
//               max: Duration(minutes: 1),
//             ),
//           ),
//         ),
//     );
//   }

//   Future<AssetEntity?> _pickFromCamera(BuildContext c) {
//     return CameraPicker.pickFromCamera(
//       c,
//       locale: L10n.all[2],
//       pickerConfig: const CameraPickerConfig(
//           enableRecording: true,
//           maximumRecordingDuration: Duration(seconds: 60)),
//     );
//   }
// }
