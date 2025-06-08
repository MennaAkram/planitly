import 'package:dartz/dartz.dart';
import 'package:planitly/features/category/domain/entity/category_info.dart';
import 'package:planitly/shared/networking/failures.dart';

abstract class CategoryRepository {
  Future<Either<NetworkException, CategoryInfo>> getCategoryInfo({
    required String categoryId,
    int offset = 0,
  });
}
