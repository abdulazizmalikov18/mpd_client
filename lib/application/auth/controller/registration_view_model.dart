import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpd_client/application/accounts/accounts_bloc.dart';
import 'package:mpd_client/domain/entity/auth/region_sel.dart';
import 'package:mpd_client/domain/models/auth/create_user_model.dart';
import 'package:mpd_client/infrastructure/reopsitories/auth_repository.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';
import 'package:mpd_client/infrastructure/services/storage_repo_service.dart';

typedef $regVM = RegistrationViewModel;

class RegistrationViewModel {
  final AuthRepository _repo = const AuthRepository();
  static RegistrationViewModel instance = RegistrationViewModel._();

  RegistrationViewModel._();

  RegistrationViewModel();

  List<RegionSelection> pageInTitle = [];
  List<RegionSelection> professionList = [];

  void registerPhone(String phone, {required void Function() onSuccess, required void Function(String errorMessage) onError}) async {
    final result = await _repo.checkUser(phone);
    if (result.isRight) {
      if (!result.right) {
        final pvcResult = await _repo.sendPvc(phone);
        if (pvcResult.isRight && pvcResult.right) {
          onSuccess();
        } else {
          onError("Pvc Error");
        }
      } else {
        onError("Bunday User Oldin Registratsiya qilingan");
      }
    } else {
      onError("Server Error");
    }
  }

  void reSendPvc(String phone, {required void Function() onSuccess, required void Function(String errorMessage) onError}) {}

  void confirmPvc(String phone, String pvc, {required void Function() onSuccess, required void Function(String errorMessage) onError}) async {
    final result = await _repo.confirmPvc(phone, pvc);
    if (result.isRight) {
      if (result.right) {
        onSuccess();
      } else {
        onError("Notog'ri");
      }
    } else {
      onError("Server Error");
    }
  }

  void checkLogin(String login, {required void Function() onSuccess, required void Function(String errorMessage) onError}) async {
    final result = await _repo.checkLogin(login);
    if (result.isRight) {
      if (!result.right) {
        onSuccess();
      } else {
        onError("Bunday Login Mavjud");
      }
    } else {
      onError("Server error");
    }
  }

  void checkPassword(String password, String secondPassword, {required void Function() onSuccess, required void Function(String errorMessage) onError}) {
    if (password != secondPassword) {
      onError("Parol notog'ri iltimos qayta tekshirib ko'ring !");
      return;
    }
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (password.isEmpty) {
      onError('Iltimos Parolni kiriting !');
      return;
    } else {
      if (!regex.hasMatch(password)) {
        onError('Bu parol shartlarga mos kelmadi !');
        return;
      } else {
        onSuccess();
        return;
      }
    }
  }

  void changePassword(
    String oldPassword,
    String password,
    String secondPassword, {
    required void Function() onSuccess,
    required void Function(String errorMessage) onError,
  }) async {
    if (password != secondPassword) {
      onError("Parol notog'ri iltimos qayta tekshirib urinib ko'ring !");
      return;
    }
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (password.isEmpty) {
      onError('Iltimos Parolni kiriting !');
      return;
    } else {
      if (!regex.hasMatch(password)) {
        onError('Bu parol shartlarga mos kelmadi !');
        return;
      } else {
        final result = await _repo.changePassword(oldPassword, password, secondPassword);
        if (result.isRight && result.right) {
          onSuccess();
          return;
        } else {
          onError("Iltimos qayta urinib ko'ring");
        }
        return;
      }
    }
  }

  void setUserData(
    CreateUser user,
    String? avatar, {
    required void Function() onSuccess,
    required void Function(String errorMessage) onError,
  }) async {
    if (user.name?.isEmpty ?? true) {
      onError("Iltimos Ismingizni kiriting !");
      return;
    }
    if (user.lastname?.isEmpty ?? true) {
      onError("Iltimos Familyangizni kiriting kiriting !");
      return;
    }
    if (user.birthday?.isEmpty ?? true) {
      onError("Iltimos Tug'ilgan kuningizni kiriting kiriting !");
      return;
    }
    Log.i(user.toString());

    try {
      final result = await _repo.createUser(user, avatar);
      if (result.isRight) {
        Log.e("${result.right}");
        StorageRepository.putBool(StorageKeys.ISLOGGED, true);
        StorageRepository.putString(StorageKeys.TOKEN, result.right.access!);
        StorageRepository.putString(StorageKeys.REFRESH, result.right.refresh!);
        onSuccess();
      } else {
        onError("Server Error");
      }
    } catch (e) {
      onError("Xatolik qayta urinib ko'ring !");
    }
  }

  void selectPag(BuildContext context, int ind, String name, int id) async {
    if (ind == 1 || ind == 2) {
      if (name.isNotEmpty) {
        pageInTitle.add(RegionSelection(id: id, name: name));
      } else {
        pageInTitle.removeLast();
      }
    } else {
      pageInTitle = [];
    }
    context.read<AccountsBloc>().add(GetRegion(index: ind, id: id));
  }

  void selectPagProffesion(BuildContext context, int ind, String name, int id) async {
    if (ind == 1 || ind == 2) {
      if (name.isNotEmpty) {
        professionList.add(RegionSelection(id: id, name: name));
      } else {
        professionList.removeLast();
      }
    } else {
      professionList = [];
    }
    context.read<AccountsBloc>().add(GetProfession(index: ind, id: id));
  }
}
