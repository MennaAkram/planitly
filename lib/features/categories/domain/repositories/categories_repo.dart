import 'package:dartz/dartz.dart';
import 'package:planitly/features/categories/domain/entity/categories_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class CategoriesRepository {
  Future<Either<NetworkException, CategoriesInfoEntity>> getCategories(
      {int offset = 0});
}
