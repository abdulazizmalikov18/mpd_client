
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:mpd_client/domain/entity/account/profession_entity.dart';
import 'package:mpd_client/domain/entity/account/region_entity.dart';

class RegionAndProfessionContainer extends Equatable {
  final FormzSubmissionStatus statusd;
  final List<RegionEntity> regions;
  final List<RegionEntity> regions1;
  final List<RegionEntity> regions2;
  final List<ProfessionEntity> profession;
  final List<ProfessionEntity> profession2;
  const RegionAndProfessionContainer({
    this.statusd = FormzSubmissionStatus.initial,
    this.regions = const [],
    this.regions1 = const [],
    this.regions2 = const [],
    this.profession = const [],
    this.profession2 = const [],
  });

  RegionAndProfessionContainer copyWith({
    FormzSubmissionStatus? statusd,
    FormzSubmissionStatus? statusAccounts,
    List<RegionEntity>? regions,
    List<RegionEntity>? regions1,
    List<RegionEntity>? regions2,
    bool? isFocused,
    List<ProfessionEntity>? profession,
    List<ProfessionEntity>? profession2,
  }) =>
      RegionAndProfessionContainer(
        statusd: statusd ?? this.statusd,
        regions: regions ?? this.regions,
        regions1: regions1 ?? this.regions1,
        regions2: regions2 ?? this.regions2,
        profession: profession ?? this.profession,
        profession2: profession2 ?? this.profession2,
      );

  @override
  List<Object> get props => [
    statusd,
    regions,
    regions1,
    regions2,
    profession,
    profession2,
  ];
}
