import 'package:dartz/dartz.dart';
import 'package:planitly/features/categories/data/remote/categories_info_dto.dart';
import 'package:planitly/features/categories/data/remote/category_dto.dart';
import 'package:planitly/features/categories/domain/entity/categories_info_entity.dart';
import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/features/categories/domain/repositories/categories_repo.dart';
import 'package:planitly/features/category/data/remote/category_info_dto.dart';
import 'package:planitly/features/category/domain/entity/category_info_entity.dart';
import 'package:planitly/shared/bases/base_repo.dart';
import 'package:planitly/shared/configs/endpoints.dart';
import 'package:planitly/shared/networking/failures.dart';

class CategoriesRepositoryImpl extends BaseRepository
    implements CategoriesRepository {
  CategoriesRepositoryImpl(super.dio);

  @override
  Future<Either<NetworkException, CategoriesInfoEntity>> getCategories(
      {int offset = 0}) async {
    return await tryToExecute(
        () => dio.get(EndPoints.categories, queryParameters: {
              'skip': offset,
            }), (response) {
      return CategoriesInfoDto().fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<NetworkException, CategoryInfoEntity>> getUncategorizedPages(
      {int offset = 0}) async {
    return await tryToExecute(
        () => dio.get(EndPoints.uncategorizedPages, queryParameters: {
              'skip': offset,
            }), (response) {
      return CategoryInfoDto().fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<NetworkException, CategoryEntity>> addCategory(
      {required String name, required List<String> pageIds}) async {
    return await tryToExecute(
        () => dio.post(EndPoints.categories,
            data: {'name': name, 'subject_ids': pageIds}), (response) {
      return CategoryDto().fromJson(response).toEntity();
    });
  }

  @override
  Future<Either<NetworkException, bool>> deleteCategory(
      {required String categoryName}) async {
    return await tryToExecute(
        () => dio.delete(EndPoints.deleteCategory(categoryName)), (response) {
      return true;
    });
  }
}
