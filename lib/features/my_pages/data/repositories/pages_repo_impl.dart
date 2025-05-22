import 'package:dartz/dartz.dart';
import 'package:planitly/features/my_pages/data/remote/page_dto.dart';
import 'package:planitly/features/my_pages/data/remote/pages_info_dto.dart';
import 'package:planitly/features/my_pages/domain/entity/page_entity.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/features/my_pages/domain/repositories/pages_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class PagesRepositoryImpl extends BaseRepository implements PagesRepository {
  PagesRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, PagesInfoEntity>> getPages(
      {int offset = 0}) async {
    return tryToExecute(
        () => dio.get(EndPoints.pages, queryParameters: {
              'skip': offset,
            }), (response) {
      return PagesInfoDto().fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<NetworkException, PageEntity>> addPage(
      {required String name}) async {
    return tryToExecute(() => dio.post(EndPoints.pages, data: {'name': name}),
        (response) {
      return PageDto().fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<NetworkException, bool>> deletePage(
      {required String pageId}) async {
    return tryToExecute(() => dio.delete(EndPoints.subject(pageId)),
        (response) {
      return true;
    });
  }
}
