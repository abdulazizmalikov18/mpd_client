// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialist_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialistOrderModel _$SpecialistOrderModelFromJson(
  Map<String, dynamic> json,
) => SpecialistOrderModel(
  id: json['id'] as String? ?? "",
  number: (json['number'] as num?)?.toInt() ?? 0,
  qrCode: json['qr_code'] as String? ?? "",
  organization: json['organization'] == null
      ? const Organization()
      : Organization.fromJson(json['organization'] as Map<String, dynamic>),
  meetAddress: json['meet_address'] ?? "",
  info: json['info'] ?? "",
  clientComment: json['client_comment'] as String? ?? "",
  user: json['user'] == null
      ? const User()
      : User.fromJson(json['user'] as Map<String, dynamic>),
  status: (json['status'] as num?)?.toInt() ?? 0,
  rates: json['rates'] ?? "",
  payment: (json['payment'] as num?)?.toInt() ?? 0,
  paymentStatus: (json['payment_status'] as num?)?.toInt() ?? 0,
  prepaidAmount: (json['prepaid_amount'] as num?)?.toInt() ?? 0,
  totalCost: (json['total_cost'] as num?)?.toInt() ?? 0,
  deviceId: (json['device_id'] as num?)?.toInt() ?? 0,
  specsComment: json['specs_comment'] ?? "",
  productNumber: (json['product_number'] as num?)?.toInt() ?? 0,
  creator: json['creator'] == null
      ? const Creator()
      : Creator.fromJson(json['creator'] as Map<String, dynamic>),
  insertedValue: (json['inserted_value'] as num?)?.toInt() ?? 0,
  createDate: json['create_date'] as String? ?? "",
  finishDate: json['finish_date'] as String? ?? "",
  ofdReceiptData: json['ofd_receipt_data'] ?? "",
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SpecialistOrderModelToJson(
  SpecialistOrderModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'qr_code': instance.qrCode,
  'organization': instance.organization,
  'meet_address': instance.meetAddress,
  'info': instance.info,
  'client_comment': instance.clientComment,
  'user': instance.user,
  'status': instance.status,
  'rates': instance.rates,
  'payment': instance.payment,
  'payment_status': instance.paymentStatus,
  'prepaid_amount': instance.prepaidAmount,
  'total_cost': instance.totalCost,
  'device_id': instance.deviceId,
  'specs_comment': instance.specsComment,
  'product_number': instance.productNumber,
  'creator': instance.creator,
  'inserted_value': instance.insertedValue,
  'create_date': instance.createDate,
  'finish_date': instance.finishDate,
  'ofd_receipt_data': instance.ofdReceiptData,
  'products': instance.products,
};

Creator _$CreatorFromJson(Map<String, dynamic> json) => Creator(
  id: (json['id'] as num?)?.toInt() ?? 0,
  org: json['org'] as String? ?? "",
  name: json['name'] as String? ?? "",
  lastname: json['lastname'] as String? ?? "",
  job: json['job'] as String? ?? "",
  creatorPhone: json['creator_phone'] as String?,
);

Map<String, dynamic> _$CreatorToJson(Creator instance) => <String, dynamic>{
  'id': instance.id,
  'org': instance.org,
  'name': instance.name,
  'lastname': instance.lastname,
  'job': instance.job,
  'creator_phone': instance.creatorPhone,
};

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
  slugName: json['slug_name'] as String? ?? "",
  name: json['name'] as String? ?? "",
);

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{'slug_name': instance.slugName, 'name': instance.name};

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num?)?.toInt() ?? 0,
  order: json['order'] as String? ?? "",
  product: (json['product'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? "",
  qty: (json['qty'] as num?)?.toInt() ?? 0,
  cost: (json['cost'] as num?)?.toInt() ?? 0,
  coupon: json['coupon'] ?? 0,
  status: (json['status'] as num?)?.toInt() ?? 0,
  fullCost: (json['full_cost'] as num?)?.toInt() ?? 0,
  discountType: json['discount_type'] ?? 0,
  surcharge: (json['surcharge'] as num?)?.toInt() ?? 0,
  meetDate: json['meet_date'] as String? ?? "",
  expectedEndDate: json['expected_end_date'] ?? 0,
  responsible: json['responsible'] == null
      ? const Creator()
      : Creator.fromJson(json['responsible'] as Map<String, dynamic>),
  image: json['image'] as String? ?? "",
  currentWorkState: json['current_work_state'] == null
      ? const CurrentWorkState()
      : CurrentWorkState.fromJson(
          json['current_work_state'] as Map<String, dynamic>,
        ),
  workStateCount: (json['work_state_count'] as num?)?.toInt() ?? 0,
  addCharge: (json['add_charge'] as num?)?.toInt() ?? 0,
  createDate: json['create_date'] as String? ?? "",
  finishDate: json['finish_date'] ?? 0,
  textCheck: json['text_check'] ?? 0,
  createdAt: json['created_at'] as String? ?? "",
  addedBy: json['added_by'] == null
      ? const AddedBy()
      : AddedBy.fromJson(json['added_by'] as Map<String, dynamic>),
  discount: (json['discount'] as num?)?.toInt() ?? 0,
  vat: (json['vat'] as num?)?.toInt() ?? 0,
  isFree: json['is_free'] as bool? ?? false,
  isChanged: json['is_changed'] as bool? ?? false,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'order': instance.order,
  'product': instance.product,
  'name': instance.name,
  'qty': instance.qty,
  'cost': instance.cost,
  'coupon': instance.coupon,
  'status': instance.status,
  'full_cost': instance.fullCost,
  'discount_type': instance.discountType,
  'surcharge': instance.surcharge,
  'meet_date': instance.meetDate,
  'expected_end_date': instance.expectedEndDate,
  'responsible': instance.responsible,
  'image': instance.image,
  'current_work_state': instance.currentWorkState,
  'work_state_count': instance.workStateCount,
  'add_charge': instance.addCharge,
  'create_date': instance.createDate,
  'finish_date': instance.finishDate,
  'text_check': instance.textCheck,
  'created_at': instance.createdAt,
  'added_by': instance.addedBy,
  'discount': instance.discount,
  'vat': instance.vat,
  'is_free': instance.isFree,
  'is_changed': instance.isChanged,
};

AddedBy _$AddedByFromJson(Map<String, dynamic> json) => AddedBy(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? "",
  lastname: json['lastname'] as String? ?? "",
);

Map<String, dynamic> _$AddedByToJson(AddedBy instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'lastname': instance.lastname,
};

CurrentWorkState _$CurrentWorkStateFromJson(Map<String, dynamic> json) =>
    CurrentWorkState(
      id: (json['id'] as num?)?.toInt() ?? 0,
      statusId: (json['status_id'] as num?)?.toInt() ?? 0,
      specialistId: (json['specialist_id'] as num?)?.toInt() ?? 0,
      status: json['status'] == null
          ? const Status()
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      specialist: json['specialist'] == null
          ? const Creator()
          : Creator.fromJson(json['specialist'] as Map<String, dynamic>),
      readOnly: json['read_only'] as bool? ?? false,
      organization: json['organization'] as String? ?? "",
      startTime: json['start_time'] as String? ?? "",
      endTime: json['end_time'] ?? 0,
      createDate: json['create_date'] as String? ?? "",
      isCurrent: json['is_current'] as bool? ?? false,
      isLast: json['is_last'] as bool? ?? false,
      isFirst: json['is_first'] as bool? ?? false,
      isReturned: json['is_returned'] as bool? ?? false,
      product: (json['product'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CurrentWorkStateToJson(CurrentWorkState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status_id': instance.statusId,
      'specialist_id': instance.specialistId,
      'status': instance.status,
      'specialist': instance.specialist,
      'read_only': instance.readOnly,
      'organization': instance.organization,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'create_date': instance.createDate,
      'is_current': instance.isCurrent,
      'is_last': instance.isLast,
      'is_first': instance.isFirst,
      'is_returned': instance.isReturned,
      'product': instance.product,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? "",
  key: json['key'] as String? ?? "",
  readOnly: json['read_only'] as bool? ?? false,
  image: json['image'] as String? ?? "",
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'key': instance.key,
  'read_only': instance.readOnly,
  'image': instance.image,
};

Type _$TypeFromJson(Map<String, dynamic> json) =>
    Type(id: json['id'] as String? ?? "", name: json['name'] as String? ?? "");

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  username: json['username'] as String? ?? "",
  name: json['name'] as String? ?? "",
  lastname: json['lastname'] as String? ?? "",
  mainCat: json['main_cat'] == null
      ? null
      : MainCat.fromJson(json['main_cat'] as Map<String, dynamic>),
  avatar: json['avatar'] as String?,
  gender: json['gender'] as String? ?? "",
  birthdate: json['birthdate'] as String?,
  region: json['region'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'username': instance.username,
  'name': instance.name,
  'lastname': instance.lastname,
  'main_cat': instance.mainCat,
  'avatar': instance.avatar,
  'gender': instance.gender,
  'birthdate': instance.birthdate,
  'region': instance.region,
};

MainCat _$MainCatFromJson(Map<String, dynamic> json) => MainCat(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? "",
);

Map<String, dynamic> _$MainCatToJson(MainCat instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
