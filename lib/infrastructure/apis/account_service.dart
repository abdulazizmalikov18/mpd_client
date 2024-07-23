import 'package:chopper/chopper.dart';
import 'package:mpd_client/domain/models/account/profession_model.dart';
import 'package:mpd_client/domain/models/account/region_model.dart';
import 'package:mpd_client/domain/models/generic_pagination.dart';
import 'package:mpd_client/infrastructure/apis/apis.dart';

part 'account_service.chopper.dart';

@ChopperApi()
abstract class AccountService extends ChopperService {


  @Get(path: 'GMS/api/v1.0/public/region/')
  Future<GenericPagination<RegionModel>> getRegion({
    @Header('Authorization') String? token,
    @QueryMap() required param,
  });

  @Get(path: 'CDMS/api/v1.0/business/category/')
  Future<GenericPagination<ProfessionModel>> getProfession({
    @Header('Authorization') String? token,
    @Query('parent') required parent,
    @Query('search') required search,
  });

  static AccountService create() => _$AccountService(clientChopper);
}
