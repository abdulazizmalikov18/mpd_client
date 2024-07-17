import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/domain/models/main/main_model.dart';
import 'package:orient_motors/domain/models/specifications/specifications.dart';
import 'package:orient_motors/utils/constants.dart';

import '../../../domain/common/token.dart';

class DBService {
  static const _dbName = 'localDB';
  static const _accessToken = 'access_token';
  static const _refreshToken = 'refresh_token';
  static const _themeMode = 'theme_mode';
  static const _language = 'language';
  static const _intro = 'intro';
  static const _likesList = "likes_list";
  static const _changedPartList = "changed_part_list";
  static const _optionList = "option_list";
  static const _currencyAmount = "currency_amount";
  static const _currencySymbol = "currency_symbol";
  static const _starsList = "stars_list";
  static const _seenList = "seen_list";

  static Box? _box;

  DBService._();

  static Future<DBService> get create async {
    _box ??= await Hive.openBox(_dbName);
    return DBService._();
  }

  /// Token
  Future<void> setToken(Token token) async {
    await _box?.put(_accessToken, token.accessToken ?? '');
    await _box?.put(_refreshToken, token.refreshToken ?? '');
  }

  Token get token {
    final accessToken = _box?.get(_accessToken);
    final refreshToken = _box?.get(_refreshToken);
    return Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  // Likes
  List<CarModel> get likesList {
    final data = _box?.get(_likesList);
    List<CarModel> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        CarModel? resultModel = CarModel.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Likes
  static List<CarModel> likesListGlobal(Box? box) {
    final data = box?.get(_likesList);
    List<CarModel> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        CarModel? resultModel = CarModel.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Likes
  Future<void> addLike(CarModel model) async {
    if (!likesList.map((e) => e.id).contains(model.id)) {
      await _box?.put(
          _likesList, [model.toJson(), ...likesList.map((e) => e.toJson())]);
    }
  }

  // Likes
  Future<void> removeLike(CarModel model) async {
    int lastIndex =
        likesList.lastIndexWhere((element) => element.id == model.id);
    if (lastIndex != -1) {
      List<CarModel> list = List.from(likesList);
      list.removeAt(lastIndex);
      await _box?.put(_likesList, list.map((e) => e.toJson()).toList());
    }
  }

  // Likes
  Future<void> removeLikes() async {
    await _box?.delete(_likesList);
  }

  // Stars
  List<FilterSearchRes> get starsList {
    final data = _box?.get(_starsList);
    List<FilterSearchRes> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        FilterSearchRes? resultModel = FilterSearchRes.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Stars
  static List<FilterSearchRes> starsListGlobal(Box? box) {
    final data = box?.get(_starsList);
    List<FilterSearchRes> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        FilterSearchRes? resultModel = FilterSearchRes.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Stars
  Future<void> addStar(FilterSearchRes model) async {
    if (!starsList.map((e) => e.id).contains(model.id)) {
      await _box?.put(
          _starsList, [model.toJson(), ...starsList.map((e) => e.toJson())]);
    }
  }

  // Stars
  Future<void> removeStar(FilterSearchRes model) async {
    if (starsList.map((e) => e.id).contains(model.id)) {
      // dprint
      final list = starsList;
      list.remove(model);
      await _box?.put(_starsList, list.map((e) => e.toJson()).toList());
    }
  }

  // Stars
  Future<void> removeStars() async {
    await _box?.delete(_starsList);
  }

  // Seen
  List<CarModel> get seenList {
    final data = _box?.get(_seenList);
    List<CarModel> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        CarModel? resultModel = CarModel.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Seen
  static List<CarModel> seenListGlobal(Box? box) {
    final data = box?.get(_seenList);
    List<CarModel> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        CarModel? resultModel = CarModel.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }

    return result;
  }

  // Seen
  Future<void> addSeen(CarModel model) async {
    if (!seenList.map((e) => e.id).contains(model.id)) {
      await _box?.put(
          _seenList, [model.toJson(), ...seenList.map((e) => e.toJson())]);
    }
  }

  // Seen
  Future<void> removeSeen(CarModel model) async {
    if (seenList.map((e) => e.id).contains(model.id)) {
      // dprint
      final list = seenList;
      list.remove(model);
      await _box?.put(_seenList, list.map((e) => e.toJson()).toList());
    }
  }

  // Seen
  Future<void> removeSeens() async {
    await _box?.delete(_seenList);
  }

  // Changed Part
  List<NamedModel> get changedPartsQualityList {
    final data = _box?.get(_changedPartList);

    List<NamedModel> result = [];
    List<String>? list = data as List<String>?;
    if (list != null) {
      for (var element in list) {
        NamedModel? resultModel = NamedModel.fromJson(element);
        if (resultModel != null) {
          result.add(resultModel);
        }
      }
    }
    return result;
  }

  // Changed Part
  Future<void> setChangedPart(List<NamedModel> model) async {
    await _box?.put(_changedPartList, model.map((e) => e.toJson()).toList());
  }

  // Options
  OptionsRes? get optionsList {
    final data = _box?.get(_optionList);
    OptionsRes? result = OptionsRes.fromJson(data);
    return result;
  }

  // Options
  Future<void> setOptionList(OptionsRes model) async {
    await _box?.put(_optionList, model.toJson());
  }

  // Currency
  CurrencyModel? get getCurrencyAmount {
    final data = _box?.get(_currencyAmount);
    if (data == null) {
      return null;
    }
    CurrencyModel? result = CurrencyModel.fromJson(data);
    return result;
  }

  // Currency
  Future<void> setCurrencyAmount(CurrencyModel model) async {
    await _box?.put(_currencyAmount, model.toJson());
  }

  // Currency
  String get getCurrencySymbol {
    final data = _box?.get(_currencySymbol);
    return data ?? listCurrency.first;
  }

  // Currency
  Future<void> setCurrencySymbol(String model) async {
    await _box?.put(_currencySymbol, model);
  }

  /// Name
  Future<void> setThemeMode(String? mode) async {
    await _box?.put(_themeMode, mode);
  }

  String? get getThemeMode {
    String? getName = _box?.get(_themeMode);
    return getName;
  }

  Future<void> signOut() async {
    bool? langSaved = getLang;
    await _box?.clear();
    setLang(isSaved: langSaved ?? false);
  }

  /// Lang
  Future<void> setLang({bool isSaved = false}) async {
    await _box?.put(_language, isSaved);
  }

  bool? get getLang {
    bool? language = _box?.get(_language, defaultValue: false);

    return language;
  }

  Future<void> setIntro({bool isSaved = false}) async {
    await _box?.put(_intro, isSaved);
  }

  bool? get getIntro {
    bool? intro = _box?.get(_intro, defaultValue: false);

    return intro;
  }

  static ValueListenable<Box> listenable() {
    return Hive.box(_dbName).listenable();
  }
}
