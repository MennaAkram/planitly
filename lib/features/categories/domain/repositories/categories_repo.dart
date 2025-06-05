import 'package:dartz/dartz.dart';
import 'package:planitly/features/categories/domain/entity/categories_info_entity.dart';
import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class CategoriesRepository {
  Future<Either<NetworkException, CategoriesInfoEntity>> getCategories(
      {int offset = 0});

  Future<Either<NetworkException, CategoryEntity>> addCategory(
      {required String name, required List<String> pageIds});

  Future<Either<NetworkException, bool>> deleteCategory({required String categoryName});
}
