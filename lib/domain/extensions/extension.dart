import 'package:built_collection/built_collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:orient_motors/domain/models/car/car_model.dart';
import 'package:orient_motors/domain/models/filter/filter.dart';
import 'package:orient_motors/infrastructure/services/local_database/db_service.dart';
import 'package:orient_motors/utils/constants.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension NumberExtention on double? {
  String toFormattedCurrency(
      {bool withBillion = false,
      bool withCurrencyS = true,
      required DBService dbService,
      required String? currencyS}) {
    if (this == null) {
      return '';
    }
    String currency = currencyS ?? listCurrency.first;
    double amount = this!;
    if (currency != dbService.getCurrencySymbol) {
      if (currency == listCurrency.first) {
        amount = (amount * (dbService.getCurrencyAmount?.amount ?? 1))
            .roundToDouble();
      }
      if (currency == listCurrency.last) {
        amount = (amount / (dbService.getCurrencyAmount?.amount ?? 1))
            .roundToDouble();
      }
    }
    String result = amount.toCurrencyString(
      shorteningPolicy: withBillion && '$amount'.split('.')[0].length > 9
          ? ShorteningPolicy.RoundToBillions
          : ShorteningPolicy.NoShortening,
      thousandSeparator: ThousandSeparator.Space,
    );
    if (result.endsWith('.00')) {
      result = result.replaceAll('.00', '');
    }

    if (withCurrencyS) {
      result =
          "${currency != dbService.getCurrencySymbol ? "~ " : ""}$result ${dbService.getCurrencySymbol.tr()}";
    }

    return result;
  }
}

extension CarDetailResExtention on CarModel {
  CreateCarReq toCarReq(String phoneNumber, int? regionId) {
    List<ImagesModel> images = photos
            ?.map((p0) => ImagesModel((p1) => p1
              ..url = p0.url
              ..type = p0.type))
            .toList() ??
        [];

    List<ChangedPartReq> changed = [];
    for (int i = 0; i < (changedPart?.toList() ?? []).length; i++) {
      ChangedPart? part = changedPart?[i];
      changed.add(ChangedPartReq((p0) => p0
        ..id = part?.id
        ..description = part?.description
        ..qualityId = part?.changedPartQuality?.id
        ..partId = part?.changedPart?.id));
    }
    List<AdditionalPhones> additionalPhone = [
      AdditionalPhones((p0) => p0..number = phoneNumber)
    ];
    return CreateCarReq((p0) => p0
      ..currency = currency
      ..region = region != null ? region?.id : regionId
      ..changedPart = changed.toBuiltList().toBuilder()
      ..description = description
      ..color = color?.id
      ..brand = brand?.id
      ..mileage = mileage
      ..price = price
      ..paintCondition = paintCondition?.id
      ..externalBodyKit =
          externalBodyKit?.map((p0) => p0.id ?? 0).toBuiltList().toBuilder()
      ..bodyType = bodyType?.id
      ..year = year
      ..modification = modification?.id
      ..carModel = carModel?.id
      ..transmission = transmission?.id
      ..region = region?.id
      ..configuration = modification?.configuration
      ..generation = generation?.id
      ..mediaTools =
          mediaTools?.map((p0) => p0.id ?? 0).toBuiltList().toBuilder()
      ..salon = salon?.map((p0) => p0.id ?? 0).toBuiltList().toBuilder()
      ..optics = optics?.map((p0) => p0.id ?? 0).toBuiltList().toBuilder()
      ..additionalPhones = (additionalPhones?.isEmpty ?? true)
          ? additionalPhone.toBuiltList().toBuilder()
          : additionalPhones?.toBuilder()
      ..usedCar = usedCar
      ..timeTo = timeTo
      ..fuelType = fuelType?.id
      ..barter = barter
      ..timeFrom = timeFrom
      ..time24 = time24
      ..engineSize = engineSize?.toString()
      ..horsepower = horsepower?.toString()
      ..isCheaper = isCheaper
      ..photos = images.toBuiltList().toBuilder());
  }
}
