import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UzbekAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const UzbekAssetPickerTextDelegate();

  @override
  String get confirm => 'Tasdiqlash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get edit => 'Tahrirlash';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Yuklab bo\'lmadi';

  @override
  String get original => 'Original';

  @override
  String get preview => 'Oldindan ko\'rish';

  @override
  String get select => 'Tanlash';

  @override
  String get emptyList => 'Bo\'sh ro\'yxat';

  @override
  String get unSupportedAssetType => 'Qo\'llab-quvvatlanmaydigan fayl turi';
}
