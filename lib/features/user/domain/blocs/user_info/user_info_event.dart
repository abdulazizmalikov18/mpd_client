part of 'user_info_bloc.dart';

abstract class UserInfoEvent {
  const UserInfoEvent();
}

class GetUserInfoEvent extends UserInfoEvent {}

class PostSpecialist extends UserInfoEvent {
  final int idCat;
  final int idPos;
  final int idJob;
  final String? file;
  final VoidCallback onSucces;
  final VoidCallback onError;

  PostSpecialist({
    required this.idCat,
    required this.idPos,
    required this.idJob,
    required this.onSucces,
    required this.onError,
    this.file,
  });
}

class IsAddedSpecialist extends UserInfoEvent {
  final void Function(int status) onSucces;
  final void Function() onError;

  const IsAddedSpecialist({
    required this.onSucces,
    required this.onError,
  });
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
  final String name;
  final String birthday;
  final String bio;
  final Gender gender;

  const UpdateUserProfessionEvent({
    required this.lastname,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.bio,
  });
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
  const CreateDocumentEvent();
}

class UpdateDocumentEvent extends UserInfoEvent {
  const UpdateDocumentEvent();
}

class GetDocumentEvent extends UserInfoEvent {
  const GetDocumentEvent();
}
