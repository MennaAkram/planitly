import 'package:dartz/dartz.dart';
import 'package:planitly/features/my_pages/data/remote/pages_info_dto.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class PagesRepositoryImpl extends BaseRepository implements PagesRepository {
  PagesRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, PagesInfoEntity>> getPages(
      {int index = 0}) async {
    return tryToExecute(
        () => dio.get(EndPoints.pages, queryParameters: {
              'skip': index,
            }), (response) {
      return PagesInfoDto().fromJson(response).toEntity();
    });
  }
}
