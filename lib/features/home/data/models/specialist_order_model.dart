// To parse this JSON data, do
//
//     final specialistOrderModel = specialistOrderModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'specialist_order_model.g.dart';

SpecialistOrderModel specialistOrderModelFromJson(String str) =>
    SpecialistOrderModel.fromJson(json.decode(str));

String specialistOrderModelToJson(SpecialistOrderModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class SpecialistOrderModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "number")
  final int number;
  @JsonKey(name: "qr_code")
  final String qrCode;
  @JsonKey(name: "organization")
  final Organization organization;
  @JsonKey(name: "meet_address")
  final dynamic meetAddress;
  @JsonKey(name: "info")
  final dynamic info;
  @JsonKey(name: "client_comment")
  final String? clientComment;
  @JsonKey(name: "user")
  final User user;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "rates")
  final dynamic rates;
  @JsonKey(name: "payment")
  final int? payment;
  @JsonKey(name: "payment_status")
  final int paymentStatus;
  @JsonKey(name: "prepaid_amount")
  final int? prepaidAmount;
  @JsonKey(name: "total_cost")
  final int totalCost;
  @JsonKey(name: "device_id")
  final int deviceId;
  @JsonKey(name: "specs_comment")
  final dynamic specsComment;
  @JsonKey(name: "product_number")
  final int productNumber;
  @JsonKey(name: "creator")
  final Creator? creator;
  @JsonKey(name: "inserted_value")
  final int? insertedValue;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "finish_date")
  final String finishDate;
  @JsonKey(name: "ofd_receipt_data")
  final dynamic ofdReceiptData;
  @JsonKey(name: "products")
  final List<Product> products;

  const SpecialistOrderModel({
    this.id = "",
    this.number = 0,
    this.qrCode = "",
    this.organization = const Organization(),
    this.meetAddress = "",
    this.info = "",
    this.clientComment = "",
    this.user = const User(),
    this.status = 0,
    this.rates = "",
    this.payment = 0,
    this.paymentStatus = 0,
    this.prepaidAmount = 0,
    this.totalCost = 0,
    this.deviceId = 0,
    this.specsComment = "",
    this.productNumber = 0,
    this.creator = const Creator(),
    this.insertedValue = 0,
    this.createDate = "",
    this.finishDate = "",
    this.ofdReceiptData = "",
    this.products = const [],
  });

  factory SpecialistOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialistOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialistOrderModelToJson(this);
}

@JsonSerializable()
class Creator {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "org")
  final String org;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastname")
  final String lastname;
  @JsonKey(name: "job")
  final String job;
  @JsonKey(name: "creator_phone")
  final String? creatorPhone;

  const Creator({
    this.id = 0,
    this.org = "",
    this.name = "",
    this.lastname = "",
    this.job = "",
    this.creatorPhone,
  });

  factory Creator.fromJson(Map<String, dynamic> json) =>
      _$CreatorFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorToJson(this);
}

@JsonSerializable()
class Organization {
  @JsonKey(name: "slug_name")
  final String slugName;
  @JsonKey(name: "name")
  final String name;

  const Organization({this.slugName = "", this.name = ""});

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "order")
  final String order;
  @JsonKey(name: "product")
  final int product;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "qty")
  final int qty;
  @JsonKey(name: "cost")
  final int cost;
  @JsonKey(name: "coupon")
  final dynamic coupon;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "full_cost")
  final int fullCost;
  @JsonKey(name: "discount_type")
  final dynamic discountType;
  @JsonKey(name: "surcharge")
  final int surcharge;
  @JsonKey(name: "meet_date")
  final String? meetDate;
  @JsonKey(name: "expected_end_date")
  final dynamic expectedEndDate;
  @JsonKey(name: "responsible")
  final Creator? responsible;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "current_work_state")
  final CurrentWorkState? currentWorkState;
  @JsonKey(name: "work_state_count")
  final int workStateCount;
  @JsonKey(name: "add_charge")
  final int addCharge;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "finish_date")
  final dynamic finishDate;
  // @JsonKey(name: "type")
  // final Type type;
  @JsonKey(name: "text_check")
  final dynamic textCheck;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "added_by")
  final AddedBy? addedBy;
  @JsonKey(name: "discount")
  final int discount;
  @JsonKey(name: "vat")
  final int vat;
  @JsonKey(name: "is_free")
  final bool isFree;
  @JsonKey(name: "is_changed")
  final bool isChanged;

  Product({
    this.id = 0,
    this.order = "",
    this.product = 0,
    this.name = "",
    this.qty = 0,
    this.cost = 0,
    this.coupon = 0,
    this.status = 0,
    this.fullCost = 0,
    this.discountType = 0,
    this.surcharge = 0,
    this.meetDate = "",
    this.expectedEndDate = 0,
    this.responsible = const Creator(),
    this.image = "",
    this.currentWorkState = const CurrentWorkState(),
    this.workStateCount = 0,
    this.addCharge = 0,
    this.createDate = "",
    this.finishDate = 0,
    // this.type = const Type(),
    this.textCheck = 0,
    this.createdAt = "",
    this.addedBy = const AddedBy(),
    this.discount = 0,
    this.vat = 0,
    this.isFree = false,
    this.isChanged = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class AddedBy {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastname")
  final String lastname;

  const AddedBy({this.id = 0, this.name = "", this.lastname = ""});

  factory AddedBy.fromJson(Map<String, dynamic> json) =>
      _$AddedByFromJson(json);

  Map<String, dynamic> toJson() => _$AddedByToJson(this);
}

@JsonSerializable()
class CurrentWorkState {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "status_id")
  final int statusId;
  @JsonKey(name: "specialist_id")
  final int specialistId;
  @JsonKey(name: "status")
  final Status status;
  @JsonKey(name: "specialist")
  final Creator specialist;
  @JsonKey(name: "read_only")
  final bool readOnly;
  @JsonKey(name: "organization")
  final String organization;
  @JsonKey(name: "start_time")
  final String? startTime;
  @JsonKey(name: "end_time")
  final dynamic endTime;
  @JsonKey(name: "create_date")
  final String createDate;
  @JsonKey(name: "is_current")
  final bool isCurrent;
  @JsonKey(name: "is_last")
  final bool isLast;
  @JsonKey(name: "is_first")
  final bool isFirst;
  @JsonKey(name: "is_returned")
  final bool isReturned;
  @JsonKey(name: "product")
  final int product;

  const CurrentWorkState({
    this.id = 0,
    this.statusId = 0,
    this.specialistId = 0,
    this.status = const Status(),
    this.specialist = const Creator(),
    this.readOnly = false,
    this.organization = "",
    this.startTime = "",
    this.endTime = 0,
    this.createDate = "",
    this.isCurrent = false,
    this.isLast = false,
    this.isFirst = false,
    this.isReturned = false,
    this.product = 0,
  });

  factory CurrentWorkState.fromJson(Map<String, dynamic> json) =>
      _$CurrentWorkStateFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWorkStateToJson(this);
}

@JsonSerializable()
class Status {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "key")
  final String key;
  @JsonKey(name: "read_only")
  final bool readOnly;
  @JsonKey(name: "image")
  final String image;

  const Status({
    this.id = 0,
    this.name = "",
    this.key = "",
    this.readOnly = false,
    this.image = "",
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  const Type({this.id = "", this.name = ""});

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "username")
  final String username;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "lastname")
  final String lastname;
  @JsonKey(name: "main_cat")
  final MainCat? mainCat;
  @JsonKey(name: "avatar")
  final String? avatar;
  @JsonKey(name: "gender")
  final String gender;
  @JsonKey(name: "birthdate")
  final String? birthdate;
  @JsonKey(name: "region")
  final String? region;

  const User({
    this.username = "",
    this.name = "",
    this.lastname = "",
    this.mainCat,
    this.avatar,
    this.gender = "",
    this.birthdate,
    this.region,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class MainCat {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;

  const MainCat({this.id = 0, this.name = ""});

  factory MainCat.fromJson(Map<String, dynamic> json) =>
      _$MainCatFromJson(json);

  Map<String, dynamic> toJson() => _$MainCatToJson(this);
}
