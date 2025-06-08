import 'package:dartz/dartz.dart';
import 'package:planitly/features/category/data/remote/category_info_dto.dart';
import 'package:planitly/features/category/domain/entity/category_info_entity.dart';
import 'package:planitly/features/category/domain/repository/category_repo.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class CategoryRepositoryImpl extends BaseRepository implements CategoryRepository {
  CategoryRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, CategoryInfoEntity>> getCategoryInfo(
      {required String categoryName, int offset = 0}) async {
    return await tryToExecute(
        () => dio.get(EndPoints.categorySubjects(categoryName), queryParameters: {
              'skip': offset,
            }), (response) {
      return CategoryInfoDto().fromJson(response).toEntity();
    });
  }
}
