// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_info_bloc.dart';

class UserInfoState extends Equatable {
  final UserInfoModel? userInfo;
  final Failure? failure;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusJob;
  final FormzSubmissionStatus statusPos;
  final FormzSubmissionStatus statusCat;
  final FormzSubmissionStatus statusCreate;
  final FormzSubmissionStatus statusSpec;
  final File? userImage;
  final File? userBackImage;
  final bool showLoading;
  final String error;
  final MainCat? mainCat;
  final MainCat? region;
  final bool isChanged;
  final bool isBackChanged;
  final bool isImageChanged;
  final Gender gender;
  final List<SpecialistPositionModel> specialistPosition;
  final List<SpecialistCatModel> specialistCat;
  final List<SpecialistCategoryModel> specialistCategory;
  final List<SpecialistModel> specailistModel;
  final List<UserDocumentModel> documents;
  final FormzSubmissionStatus statusDocs;
  final FormzSubmissionStatus statusDocCreate;

  const UserInfoState({
    this.status = FormzSubmissionStatus.initial,
    this.statusCreate = FormzSubmissionStatus.initial,
    this.statusJob = FormzSubmissionStatus.initial,
    this.statusPos = FormzSubmissionStatus.initial,
    this.statusCat = FormzSubmissionStatus.initial,
    this.statusSpec = FormzSubmissionStatus.initial,
    this.failure,
    this.userInfo,
    this.userImage,
    this.userBackImage,
    this.showLoading = false,
    this.error = '',
    this.mainCat,
    this.region,
    this.isChanged = false,
    this.isBackChanged = false,
    this.isImageChanged = false,
    this.gender = Gender.initial,
    this.specialistPosition = const [],
    this.specialistCat = const [],
    this.specialistCategory = const [],
    this.specailistModel = const [],
    this.documents = const [],
    this.statusDocs = FormzSubmissionStatus.initial,
    this.statusDocCreate = FormzSubmissionStatus.initial,
  });

  @override
  List<Object?> get props => [
    userInfo,
    failure,
    status,
    statusJob,
    statusPos,
    statusCat,
    statusCreate,
    statusSpec,
    userImage,
    userBackImage,
    showLoading,
    error,
    mainCat,
    region,
    isChanged,
    isBackChanged,
    isImageChanged,
    gender,
    specialistPosition,
    specialistCat,
    specialistCategory,
    specailistModel,
    documents,
    statusDocs,
    statusDocCreate,
  ];

  UserInfoState copyWith({
    UserInfoModel? userInfo,
    Failure? failure,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusJob,
    FormzSubmissionStatus? statusPos,
    FormzSubmissionStatus? statusCat,
    FormzSubmissionStatus? statusCreate,
    FormzSubmissionStatus? statusSpec,
    File? userImage,
    File? userBackImage,
    bool? showLoading,
    String? error,
    MainCat? mainCat,
    MainCat? region,
    bool? isChanged,
    bool? isBackChanged,
    bool? isImageChanged,
    Gender? gender,
    List<SpecialistPositionModel>? specialistPosition,
    List<SpecialistCatModel>? specialistCat,
    List<SpecialistCategoryModel>? specialistCategory,
    List<SpecialistModel>? specailistModel,
    List<UserDocumentModel>? documents,
    FormzSubmissionStatus? statusDocs,
    FormzSubmissionStatus? statusDocCreate,
  }) {
    return UserInfoState(
      userInfo: userInfo ?? this.userInfo,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      statusJob: statusJob ?? this.statusJob,
      statusPos: statusPos ?? this.statusPos,
      statusCat: statusCat ?? this.statusCat,
      statusCreate: statusCreate ?? this.statusCreate,
      statusSpec: statusSpec ?? this.statusSpec,
      userImage: userImage ?? this.userImage,
      userBackImage: userBackImage ?? this.userBackImage,
      showLoading: showLoading ?? this.showLoading,
      error: error ?? this.error,
      mainCat: mainCat ?? this.mainCat,
      region: region ?? this.region,
      isChanged: isChanged ?? this.isChanged,
      isBackChanged: isBackChanged ?? this.isBackChanged,
      isImageChanged: isImageChanged ?? this.isImageChanged,
      gender: gender ?? this.gender,
      specialistPosition: specialistPosition ?? this.specialistPosition,
      specialistCat: specialistCat ?? this.specialistCat,
      specialistCategory: specialistCategory ?? this.specialistCategory,
      specailistModel: specailistModel ?? this.specailistModel,
      documents: documents ?? this.documents,
      statusDocs: statusDocs ?? this.statusDocs,
      statusDocCreate: statusDocCreate ?? this.statusDocCreate,
    );
  }
}

// class UserInfoInitial extends UserInfoState {
//   const UserInfoInitial({super.userInfo, super.userLocalInfo});
// }
//
// class UserInfoLoading extends UserInfoState {
//   const UserInfoLoading({super.userInfo, super.userLocalInfo});
// }
//
// class UserInfoSuccess extends UserInfoState {
//   const UserInfoSuccess({super.userInfo, super.userLocalInfo});
// }
//
// class UserInfoFailure extends UserInfoState {
//   final Failure failure;
//
//   UserInfoFailure(
//       {required this.failure, super.userInfo, super.userLocalInfo}) {
//     debugPrint(
//         "Top Specialist error ------------------------- ${failure.message}");
//     return;
//   }
// }
