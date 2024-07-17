
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

typedef $pinVM = PinViewModel;

class PinViewModel {
  static PinViewModel instance = PinViewModel._();

  PinViewModel._();

  PinViewModel();

  void mainPinChecker(
    String pin, {
    required void Function() onSuccess,
    required void Function(String errorMessage) onError,
    required void Function() onSave,
  }) {
    if (hasPin) {
      if (StorageRepository.getString(StorageKeys.PASSWORD) == pin) {
        onSuccess();
        return;
      }
      onError("Code mos kelmadi !");
      return;
    }

    setPin(pin);
    onSave();
  }

  void setPin(String pin) async {
    await StorageRepository.putString(StorageKeys.PASSWORD, pin);
  }

  bool get hasPin => StorageRepository.getString(StorageKeys.PASSWORD).isNotEmpty;

  void clearPin() async {
    await StorageRepository.deleteString(StorageKeys.PASSWORD);
  }

  void updatePin(
    String pin,
    bool isVerified, {
    required void Function() onSuccess,
    required void Function(String errorMessage) onError,
    required void Function() onVerified,
  }) async {
    if (isVerified) {
      await StorageRepository.putString(StorageKeys.PASSWORD, pin);
      onSuccess();
    } else {
      if (StorageRepository.getString(StorageKeys.PASSWORD) == pin) {
        onVerified();
      } else {
        onError("Pin Code to'g'ri kelmadi");
      }
    }
  }
}
