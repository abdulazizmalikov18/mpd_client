import 'package:equatable/equatable.dart';
import 'package:mpd_client/domain/entity/auth/kass_org_entity.dart';
import 'package:mpd_client/domain/entity/auth/my_job_entity.dart';

class MySpecialist extends Equatable {
  final String id;
  @KassaOrgConverter()
  final KassaOrgEntity org;
  @MyJobConverter()
  final MyJobEntity specCat;
  final String name;
  final String lastname;
  @MyJobConverter()
  final MyJobEntity job;
  final bool auto;
  final String avatar;
  final String locationDesc;
  // @LocationConverter()
  // final LocationEntity location;

  const MySpecialist({
    this.id = "",
    this.org = const KassaOrgEntity(),
    this.specCat = const MyJobEntity(),
    this.name = "",
    this.lastname = "",
    this.job = const MyJobEntity(),
    this.auto = false,
    this.avatar = "",
    this.locationDesc = "",
    // this.location = const LocationEntity(),
  });

  @override
  List<Object?> get props => [
        id,
        org,
        specCat,
        name,
        lastname,
        job,
        auto,
        avatar,
        locationDesc,
        // location,
      ];
}
