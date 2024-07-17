import 'package:equatable/equatable.dart';

class ProfessionEntity extends Equatable {
  final int id;
  final bool isParent;
  final int childNumber;
  final String name;
  final bool hideFromOrgs;
  final bool hideFromUsers;
  final String image;
  final int status;
  final String description;
  final int firstLevelScore;
  final int levelProgressBy;
  final dynamic parent;

  const ProfessionEntity({
    this.id = 0,
    this.isParent = false,
    this.childNumber = 0,
    this.name = "",
    this.hideFromOrgs = false,
    this.hideFromUsers = false,
    this.image = "",
    this.status = 0,
    this.description = "",
    this.firstLevelScore = 0,
    this.levelProgressBy = 0,
    this.parent = 0,
  });

  @override
  List<Object?> get props => [
        id,
        isParent,
        childNumber,
        name,
        hideFromOrgs,
        hideFromUsers,
        image,
        status,
        description,
        firstLevelScore,
        levelProgressBy,
        parent,
      ];
}
