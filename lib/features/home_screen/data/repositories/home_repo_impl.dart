import 'package:dartz/dartz.dart';
import 'package:planitly/features/home_screen/data/remote/home_dto.dart';
import 'package:planitly/features/home_screen/domain/entity/home_entity.dart';
import 'package:planitly/features/home_screen/domain/repositories/home_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

import '../../../../shared/bases/base_repo.dart';

class HomeRepositoryImpl extends BaseRepository
    implements HomeRepository {

  HomeRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, HomeEntity>> getHomeData() {
    return tryToExecute<HomeEntity>(
          () => dio.get(EndPoints.home),
          (response) {
        return HomeDto().fromJson(response).toEntity();
      },
    );
  }


}