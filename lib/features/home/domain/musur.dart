import 'package:mpd_client/app/app_export.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UzbekAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const UzbekAssetPickerTextDelegate();

  @override
  String get languageCode => 'uz';

  @override
  String? get scriptCode => null;

  @override
  String? get countryCode => null;

  @override
  String get confirm => 'Tasdiqlash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get edit => 'Tahrirlash';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get livePhotoIndicator => 'LIVE';

  @override
  String get loadFailed => 'Yuklanmadi';

  @override
  String get original => 'Asl nusxa';

  @override
  String get preview => 'Ko\'rib chiqish';

  @override
  String get select => 'Tanlash';

  @override
  String get emptyList => 'Ro\'yxat bo\'sh';

  @override
  String get unSupportedAssetType => 'HEIC formati qo\'llab-quvvatlanmaydi.';

  @override
  String get unableToAccessAll =>
      'Qurilmadagi barcha fayllarga kirish imkoni yo\'q';

  @override
  String get viewingLimitedAssetsTip =>
      'Faqat ilovaga ruxsat etilgan fayllar va albomlar ko\'rsatilmoqda.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Ruxsat etilgan fayllarni yangilash';

  @override
  String get accessAllTip =>
      'Ilova qurilmadagi faqat ba\'zi fayllarga kira oladi. '
      'Tizim sozlamalariga o\'ting va ilovaga barcha fayllarga kirishga ruxsat bering.';

  @override
  String get goToSystemSettings => 'Sozlamalarga o\'tish';

  @override
  String get accessLimitedAssets => 'Cheklangan kirish bilan davom etish';

  @override
  String get accessiblePathName => 'Mavjud fayllar';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Rasm';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Boshqa fayl';

  @override
  String get sActionPlayHint => 'ijro etish';

  @override
  String get sActionPreviewHint => 'ko\'rib chiqish';

  @override
  String get sActionSelectHint => 'tanlash';

  @override
  String get sActionSwitchPathLabel => 'yo\'lni o\'zgartirish';

  @override
  String get sActionUseCameraHint => 'kamerani ishlatish';

  @override
  String get sNameDurationLabel => 'davomiyligi';

  @override
  String get sUnitAssetCountLabel => 'soni';

  @override
  String durationIndicatorBuilder(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

AssetPickerTextDelegate resolveDelegate(BuildContext context) {
  final locale = Localizations.localeOf(context);

  return switch (locale.languageCode) {
    'uz' => const UzbekAssetPickerTextDelegate(),
    'ru' => const RussianAssetPickerTextDelegate(), // paketda bor
    _ => const EnglishAssetPickerTextDelegate(), // paketda bor
  };
}
