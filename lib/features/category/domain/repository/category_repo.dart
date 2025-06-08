import 'package:dartz/dartz.dart';
import 'package:planitly/features/category/domain/entity/category_info_entity.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class CategoryRepository {
  Future<Either<NetworkException, CategoryInfoEntity>> getCategoryInfo({
    required String categoryName,
    int offset = 0,
  });
}
