part of 'user_info_bloc.dart';

abstract class UserInfoEvent {
  const UserInfoEvent();
}

class GetUserInfoEvent extends UserInfoEvent {}

class PostSpecialist extends UserInfoEvent {
  final int idCat;
  // final int idPos;
  final int idJob;
  final String? file;
  final String? bio;
  final VoidCallback onSucces;
  final VoidCallback onError;

  PostSpecialist({
    required this.idCat,
    // required this.idPos,
    required this.idJob,
    this.bio,
    required this.onSucces,
    required this.onError,
    this.file,
  });
}

class IsAddedSpecialist extends UserInfoEvent {
  final void Function(int status) onSucces;
  final void Function() onError;

  const IsAddedSpecialist({required this.onSucces, required this.onError});
}

class GetSpecialistPosition extends UserInfoEvent {}

class GetSpecialistCat extends UserInfoEvent {}

class GetSpecialistUser extends UserInfoEvent {}

class GetSpecCategory extends UserInfoEvent {}

class DeleteUserInfo extends UserInfoEvent {}

class UpdateUserInfoLocal extends UserInfoEvent {}

class UpdateUserBirthEvent extends UserInfoEvent {
  final DateTime dateTime;

  const UpdateUserBirthEvent(this.dateTime);
}

class UpdateUserProfessionEvent extends UserInfoEvent {
  final String lastname;
  final String surname;
  final String name;
  final String birthday;
  final String bio;
  final Gender gender;
  final String? diplom;
  final String? pinfl;
  final String? course;
  final String? education;
  final String? currentPlace;
  final Function onSuccess;
  final Function onError;

  const UpdateUserProfessionEvent({
    required this.lastname,
    required this.surname,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.bio,
    this.diplom,
    this.pinfl,
    this.course,
    this.education,
    this.currentPlace,
    required this.onSuccess,
    required this.onError,
  });
}

class UpdateUserVerifyEvent extends UserInfoEvent {
  final int? mainCat;
  final int? region;

  const UpdateUserVerifyEvent({this.mainCat, this.region});
}

class SelectedCategoryIdEvent extends UserInfoEvent {
  final MainCat mainCat;
  final String localCatName;

  const SelectedCategoryIdEvent(this.mainCat, {required this.localCatName});
}

class SelectedRegionIdEvent extends UserInfoEvent {
  final MainCat region;
  final String localRegion;

  const SelectedRegionIdEvent(this.region, {required this.localRegion});
}

class SelectUserImage extends UserInfoEvent {}

class SelectUserBackImage extends UserInfoEvent {}

class UpdateUserImage extends UserInfoEvent {}

class UpdateUserBackImage extends UserInfoEvent {}

class HasChangesEvent extends UserInfoEvent {
  const HasChangesEvent();
}

class CreateDocumentEvent extends UserInfoEvent {
  final String filePath;
  final String description;
  final Function onSuccess;
  final Function onError;

  const CreateDocumentEvent({
    required this.filePath,
    required this.description,
    required this.onSuccess,
    required this.onError,
  });
}

class UpdateDocumentEvent extends UserInfoEvent {
  const UpdateDocumentEvent();
}

class GetDocumentEvent extends UserInfoEvent {
  const GetDocumentEvent();
}
